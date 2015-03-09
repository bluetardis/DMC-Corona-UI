# DMC-Corona-Widgets

try:
	if not gSTARTED: print( gSTARTED )
except:
	MODULE = "DMC-Corona-Widgets"
	include: "../DMC-Corona-Widgets/snakemake/Snakefile"

module_config = {
	"name": "DMC-Corona-Widgets",
	"module": {
		"dir": "lib",
		"files": [
			"dmc_ui.lua",
			"dmc_ui/ui_constants.lua",
			"dmc_ui/ui_utils.lua",

			"dmc_ui/dmc_control.lua",
			#"dmc_ui/dmc_control/navigation_control.lua",

			"dmc_ui/dmc_style.lua",
			"dmc_ui/dmc_style/background_style.lua",
			"dmc_ui/dmc_style/background_style/base_view_style.lua",
			"dmc_ui/dmc_style/background_style/rectangle_style.lua",
			"dmc_ui/dmc_style/background_style/rounded_style.lua",
			"dmc_ui/dmc_style/background_style/style_factory.lua",
			"dmc_ui/dmc_style/base_style.lua",
			"dmc_ui/dmc_style/button_state.lua",
			"dmc_ui/dmc_style/button_style.lua",
			"dmc_ui/dmc_style/navbar_style.lua",
			"dmc_ui/dmc_style/navitem_style.lua",
			"dmc_ui/dmc_style/style_manager.lua",
			"dmc_ui/dmc_style/style_mix.lua",
			"dmc_ui/dmc_style/text_style.lua",
			"dmc_ui/dmc_style/textfield_style.lua",

			"dmc_ui/dmc_widget.lua",
			"dmc_ui/dmc_widget/button_group.lua",
			"dmc_ui/dmc_widget/data_formatters.lua",
			"dmc_ui/dmc_widget/font_manager.lua",
			"dmc_ui/dmc_widget/lib/easingx.lua",
			"dmc_ui/dmc_widget/scroller_view_base.lua",
			"dmc_ui/dmc_widget/widget_background.lua",
			"dmc_ui/dmc_widget/widget_background/rectangle_view.lua",
			"dmc_ui/dmc_widget/widget_background/rounded_view.lua",
			"dmc_ui/dmc_widget/widget_background/view_factory.lua",
			"dmc_ui/dmc_widget/widget_button.lua",
			"dmc_ui/dmc_widget/widget_button/view_9slice.lua",
			"dmc_ui/dmc_widget/widget_button/view_base.lua",
			"dmc_ui/dmc_widget/widget_button/view_image.lua",
			"dmc_ui/dmc_widget/widget_button/view_shape.lua",
			"dmc_ui/dmc_widget/widget_navbar.lua",
			"dmc_ui/dmc_widget/widget_navitem.lua",
			"dmc_ui/dmc_widget/widget_popover.lua",
			"dmc_ui/dmc_widget/widget_popover/popover_mix.lua",
			"dmc_ui/dmc_widget/widget_popover/popover_view.lua",
			"dmc_ui/dmc_widget/widget_slideview.lua",
			"dmc_ui/dmc_widget/widget_tableview.lua",
			"dmc_ui/dmc_widget/widget_text.lua",
			"dmc_ui/dmc_widget/widget_textfield.lua",
			"dmc_ui/dmc_widget/widget_viewpager.lua"
		],
		"requires": [
			"dmc-corona-boot",
			"DMC-Lua-Library",
			"DMC-Corona-Library"
		]
	},
	"examples": {
		"base_dir": "examples",
		"apps": [
			{
				"exp_dir": "background-widget/background-styled",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "background-widget/background-themed",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "button-widget/button-9slice-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "button-widget/button-image-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "button-widget/button-radio-group",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "button-widget/button-shape-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "button-widget/button-text-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "navbar-widget/navbar-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "navbar-widget/navbar-styled",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "navigation-control/navigation-control-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "popover-widget/popover-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "slide_view-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "table_view-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "text-widget/text-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "text-widget/text-styled",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "textfield-widget/textfield-simple",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			},
			{
				"exp_dir": "textfield-widget/textfield-styled",
				"requires": [],
				"mod_dir_map": {
					"default_dir": "",
					"libs": {
						"dmc-corona-boot":""
					}
				}
			}
		]
	},
	"tests": {
		"dir": "spec",
		"files": [],
		"requires": []
	}
}

register( "DMC-Corona-Widgets", module_config )


