--== Project 

title = "DMC Corona UI API"
project = "DMC Corona UI"
description = [[
Awesome UI Widgets for the Corona SDK.
]]

--== Setup

alias("p","param")
tparam_alias("object","object")

--== Input 

-- Put these in order as wanted in listing

file = {
	'lib/dmc_ui.lua',

	'lib/dmc_ui/core/style.lua',
	'lib/dmc_ui/core/widget.lua',

	-- Delegates 
	
	'lib/dmc_ui/dmc_widget/widget_navbar/delegate_navbar.lua',
	
	'lib/dmc_ui/dmc_widget/widget_tableview/delegate_tableview.lua',

	'lib/dmc_ui/dmc_widget/widget_textfield/delegate_textfield.lua',

	-- Styles 
		
	'lib/dmc_ui/dmc_style/background_style.lua',
	'lib/dmc_ui/dmc_style/background_style/nine_slice_style.lua',
	'lib/dmc_ui/dmc_style/background_style/rectangle_style.lua',
	'lib/dmc_ui/dmc_style/background_style/rounded_style.lua',

	'lib/dmc_ui/dmc_style/button_style.lua',


	'lib/dmc_ui/dmc_style/tableview_style.lua',
	'lib/dmc_ui/dmc_style/tableviewcell_style.lua',
	'lib/dmc_ui/dmc_style/tableviewcell_style/tableviewcell_state.lua',

	'lib/dmc_ui/dmc_style/text_style.lua',

	'lib/dmc_ui/dmc_style/textfield_style.lua',


	-- Widgets 
	
	'lib/dmc_ui/dmc_widget/widget_background.lua',
	--'lib/dmc_ui/dmc_widget/widget_background/nine_slice_view.lua',
	--'lib/dmc_ui/dmc_widget/widget_background/rectangle_view.lua',
	--'lib/dmc_ui/dmc_widget/widget_background/rounded_view.lua',
	
	'lib/dmc_ui/dmc_widget/widget_button.lua',
	'lib/dmc_ui/dmc_widget/widget_button/button_push.lua',
	'lib/dmc_ui/dmc_widget/widget_button/button_radio.lua',
	'lib/dmc_ui/dmc_widget/widget_button/button_toggle.lua',

	'lib/dmc_ui/dmc_widget/widget_navbar.lua',
	'lib/dmc_ui/dmc_widget/widget_navitem.lua',

	'lib/dmc_ui/dmc_widget/widget_scrollview.lua',

	'lib/dmc_ui/dmc_widget/widget_tableview.lua',
	'lib/dmc_ui/dmc_widget/widget_tableviewcell.lua',

	'lib/dmc_ui/dmc_widget/widget_text.lua',

	'lib/dmc_ui/dmc_widget/widget_textfield.lua',

}

--== Output 

dir = "docs/api" 
ext = "html"
format='markdown'
output = "index"
sort=false
style="!fixed"

