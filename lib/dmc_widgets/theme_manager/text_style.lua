--====================================================================--
-- dmc_widgets/theme_manager/background_style.lua
--
-- Documentation: http://docs.davidmccuskey.com/
--====================================================================--

--[[

The MIT License (MIT)

Copyright (c) 2015 David McCuskey

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

--]]



--====================================================================--
--== DMC Corona Widgets : Widget Background Style
--====================================================================--


-- Semantic Versioning Specification: http://semver.org/

local VERSION = "0.1.0"



--====================================================================--
--== DMC Widgets Setup
--====================================================================--


local dmc_widget_data = _G.__dmc_widget
local dmc_widget_func = dmc_widget_data.func
local widget_find = dmc_widget_func.find



--====================================================================--
--== DMC Widgets : newTextStyle
--====================================================================--



--====================================================================--
--== Imports


local Objects = require 'dmc_objects'

local BaseStyle = require( widget_find( 'theme_manager.base_style' ) )



--====================================================================--
--== Setup, Constants


local newClass = Objects.newClass
local ObjectBase = Objects.ObjectBase



--====================================================================--
--== Text Style Class
--====================================================================--


local TextStyle = newClass( BaseStyle, {name="Text Style"} )

--== Class Constants

TextStyle.DEFAULT = {
	name='text-default-style',

	width=nil,
	height=nil,

	align='center',
	anchorX=0.5,
	anchorY=0.5,
	fillColor={1,1,1,0},
	font=native.systemFont,
	fontSize=24,
	marginX=0,
	marginY=0,
	strokeColor={0,0,0,1},
	strokeWidth=0,
	textColor={0,0,0,1}
}

--== Event Constants

-- from super
-- Class.EVENT
-- Class.STYLE_UPDATED


--======================================================--
--== Start: Setup DMC Objects

function TextStyle:__init__( params )
	-- print( "TextStyle:__init__", params )
	params = params or {}
	if params.inherit==nil then params.inherit=TextStyle end
	self:superCall( '__init__', params )
	--==--

	--== Style Properties ==--

	-- self._data
	-- self._inherit

	-- self._name
	-- self._onProperty

	self._width = nil
	self._height = nil

	self._align = nil
	self._anchorX = nil
	self._anchorY = nil
	self._fillColor = nil
	self._font = nil
	self._fontSize = nil
	self._marginX = nil
	self._marginY = nil
	self._strokeColor = nil
	self._strokeWidth = nil
	self._textColor = nil
end

--== END: Setup DMC Objects
--======================================================--



--====================================================================--
--== Static Methods


function TextStyle.setDefaults()
	-- print( "TextStyle.setDefaults" )
	local def = TextStyle.DEFAULT

	TextStyle._name=def.name

	TextStyle._width=def.width
	TextStyle._height=def.height

	TextStyle._align=def.align
	TextStyle._anchorX=def.anchorX
	TextStyle._anchorY=def.anchorY
	TextStyle._fillColor=def.fillColor
	TextStyle._font=def.font
	TextStyle._fontSize=def.fontSize
	TextStyle._marginX=def.marginX
	TextStyle._marginY=def.marginY
	TextStyle._strokeColor=def.strokeColor
	TextStyle._strokeWidth=def.strokeWidth
	TextStyle._textColor=def.textColor
end


--== updateStyle

-- force is used when making exact copy of data
--
function TextStyle:updateStyle( info, force )
	-- print( "TextStyle:updateStyle" )
	if force==nil then force=true end
	--==--
	if info.x~=nil or force then self.x=info.x end
	if info.y~=nil or force then self.y=info.y end
	if info.width~=nil or force then self.width=info.width end
	if info.height~=nil or force then self.height=info.height end

	if info.align~=nil or force then self.align=info.align end
	if info.anchorX~=nil or force then self.anchorX=info.anchorX end
	if info.anchorY~=nil or force then self.anchorY=info.anchorY end
	if info.fillColor~=nil or force then self.fillColor=info.fillColor end
	if info.font~=nil or force then self.font=info.font end
	if info.fontSize~=nil or force then self.fontSize=info.fontSize end
	if info.marginX~=nil or force then self.marginX=info.marginX end
	if info.marginY~=nil or force then self.marginY=info.marginY end
	if info.strokeColor~=nil or force then self.strokeColor=info.strokeColor end
	if info.strokeWidth~=nil or force then self.strokeWidth=info.strokeWidth end
	if info.textColor~=nil or force then self.textColor=info.textColor end
end



--====================================================================--
--== Public Methods


-- none



--====================================================================--
--== Private Methods


function TextStyle:_checkProperties()
	BaseStyle._checkProperties( self )
	--[[
	we don't check for width/height because we'll
	just use width/height of the text object
	-- assert( self.width, "Style: requires 'width'" )
	-- assert( self.height, "Style: requires 'height'" )
	--]]

	assert( self.align, "Style: requires 'align'" )
	assert( self.anchorY, "Style: requires 'anchory'" )
	assert( self.anchorX, "Style: requires 'anchorX'" )
	assert( self.fillColor, "Style: requires 'fillColor'" )
	assert( self.font, "Style: requires 'font'" )
	assert( self.fontSize, "Style: requires 'fontSize'" )
	assert( self.marginX, "Style: requires 'marginX'" )
	assert( self.marginY, "Style: requires 'marginY'" )
	assert( self.strokeColor, "Style: requires 'strokeColor'" )
	assert( self.strokeWidth, "Style: requires 'strokeWidth'" )
	assert( self.textColor, "Style: requires 'textColor'" )
end



--====================================================================--
--== Event Handlers


-- none


--== Pre-Processing ==--

TextStyle.setDefaults()



return TextStyle
