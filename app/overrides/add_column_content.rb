if SETTINGS[:column_view]
  SETTINGS[:column_view].reject { |k,v| v[:view] && v[:view] != :hosts_list }.keys.sort.map do |k|
    remove = SETTINGS[:column_view][k.to_sym][:remove]
    after = SETTINGS[:column_view][k.to_sym][:after]
    if remove != nil
      Deface::Override.new(
        :virtual_path => "hosts/_list",
        :name => "content_#{k}",
        :remove => "td:contains('#{remove}')"
      )
    elsif after != nil
      Deface::Override.new(
        :virtual_path => "hosts/_list",
        :name => "content_#{k}",
        :insert_after => "td:contains('#{after}')",
        :text => "\n    <td class=\"hidden-tablet hidden-phone ellipsis\"><%= fcv_content host, '#{k}' %></td>"
      )
    end
  end
end