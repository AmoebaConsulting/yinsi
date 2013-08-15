class BuddyScreen < PM::TableScreen
  include YinsiHelpers

  title "Buddies"
  indexable
  searchable placeholder: "Search for a buddy..."
  refreshable callback: :on_refresh,
              pull_message: "Pull to refresh",
              refreshing: "Refreshing data…",
              updated_format: "Last updated at %s",
              updated_time_format: "%l:%M %p"

  stylesheet :buddy

  def on_init
    set_tab_icon(:group, "Buddies")
    self.view.stylename = :root

    set_nav_bar_button :right, system_item: :add, action: :add_buddy
    set_nav_bar_button :back, title: 'Cancel', style: :plain, action: :back

    # Style the navigation bar (& buttons in it)
    self.navigationController.navigationBar.configureFlatNavigationBarWithColor(stylesheet_var(:green_medium))
    UIBarButtonItem.configureFlatButtonsWithColor stylesheet_var(:grey_dark),
      highlightedColor: stylesheet_var(:grey),
      cornerRadius: 3

    table_view.contentOffset = CGPointMake(0, 44)
  end

  def table_data
    [{
       cells: [
         { title: "Oregon" },
         { title: "Washington"}
       ]
     }]
  end

  def table_data_index
    #all_rows = []
    #table_data.each do |section|
    #  section[:cells].each do |cell|
    #    all_rows << cell[:title][0] if !all_rows.include?(cell[:title][0])
    #  end
    #end
    ('a'..'z').to_a
  end

  def create_search_bar(params)
    search_bar = UISearchBar.alloc.initWithFrame(params[:frame])
    search_bar.autoresizingMask = UIViewAutoresizingFlexibleWidth
    search_bar.barStyle = UIBarStyleDefault

    search_bar.subviews[0].removeFromSuperview

    search_bar
  end

  def add_buddy
    open BuddyAddScreen, in_tab: "Buddies"
  end

  def on_refresh
    Buddy.download_all do
      #TODO Actually update the table's data
      end_refreshing
      update_table_data
    end

    #MyItems.pull_from_server do |items|
    #  @my_items = items
    #  end_refreshing
    #  update_table_data
    #end
  end

  def on_return
    puts "Back from add"
  end
end