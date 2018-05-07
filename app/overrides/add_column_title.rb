if SETTINGS[:column_view]
  SETTINGS[:column_view].reject { |k,v| v[:view] && v[:view] != :hosts_list }.keys.sort.map do |k|
    remove = SETTINGS[:column_view][k.to_sym][:remove]
    after = SETTINGS[:column_view][k.to_sym][:after]
    width = SETTINGS[:column_view][k.to_sym][:width] || "10%"
    if remove != nil
      Deface::Override.new(
        :virtual_path => "hosts/_list",
        :name => "title_#{k}",
        :remove => "th:contains('#{remove}')"
      )
    elsif after != nil
      Deface::Override.new(
        :virtual_path => "hosts/_list",
        :name => "title_#{k}",
        :insert_after => "th:contains('#{after}')",
        :text => "\n    <th class=\"hidden-tablet hidden-phone\" width=\"#{width}\"><%= fcv_title '#{k}' %></th>"
      )
    end
  end
end