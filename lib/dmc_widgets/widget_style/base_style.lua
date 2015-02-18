--====================================================================--
-- dmc_widgets/base_style.lua
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
--== DMC Corona Widgets : Base Widget Style
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
--== DMC Widgets : newStyle Base
--====================================================================--



--====================================================================--
--== Imports


local Objects = require 'dmc_objects'
local Utils = require 'dmc_utils'



--====================================================================--
--== Setup, Constants


local newClass = Objects.newClass
local ObjectBase = Objects.ObjectBase

local sformat = string.format



--====================================================================--
--== Style Base Class
--====================================================================--


local Style = newClass( ObjectBase, {name="Style Base"}  )

--== Class Constants

Style.__base_style__ = nil  -- <instance of class>

-- table of properties to exclude from checking
-- these are properties which value can be 'nil'
--
Style.EXCLUDE_PROPERTY_CHECK = {} -- d

Style._STYLE_DEFAULTS = nil

--== Event Constants

Style.EVENT = 'style-event'

Style.STYLE_RESET = 'style-reset-event'
Style.STYLE_UPDATED = 'style-updated-event'


--======================================================--
-- Start: Setup DMC Objects

function Style:__init__( params )
	-- print( "Style:__init__", params )
	params = params or {}
	params.data = params.data
	if params.inherit==nil then
		params.inherit=self.class.__base_style__
	end
	params.name = params.name
	params.widget = params.widget

	self:superCall( '__init__', params )
	--==--
	-- Style inheritance tree
	self._inherit = params.inherit
	-- widget delegate
	self._parent = params.parent
	self._widget = params.widget
	self._onPropertyChange_f = params.onPropertyChange

	-- self._data = params.data
	self._tmp_data = params.data -- temporary save of data

	self._name = params.name
	self._debugOn = params.debugOn
end

function Style:__initComplete__()
	-- print( "Style:__initComplete__" )
	self:superCall( '__initComplete__' )
	--==--
	local data = self:_prepareData( self._tmp_data )
	self._tmp_data = nil

	self:_parseData( data )
	self:_checkChildren()
	assert( self:_checkProperties(), "Style: missing properties"..tostring(self.class) )
end

-- End: Setup DMC Objects
--======================================================--



--====================================================================--
--== Public Methods


-- cloneStyle()
-- make a copy of the current style setting
-- same information and inheritance
--
function Style:cloneStyle()
	local o = self.class:new{
		inherit=self._inherit
	}
	o:updateStyle( self, {force=true} ) -- clone data, force
	return o
end


-- copyStyle()
-- create a new style, setting inheritance to current style
--
function Style:copyStyle( params )
	-- print( "Style:copyStyle", self )
	params = params or {}
	params.inherit = self
	--==--
	return self.class:new( params )
end
Style.inheritStyle=Style.copyStyle


-- resetProperties()
-- sends out Reset event, tells listening Widget
-- to redraw itself
--
function Style:resetProperties()
	self:_dispatchResetEvent()
end

-- this would clear any local modifications on style class
--
function Style:clear()
	self:updateStyle( {}, {force=true} )
	self:_dispatchResetEvent()
end

function Style:getDefaultStyles()
	-- TODO: make a copy
	return self._STYLE_DEFAULTS
end


-- params:
-- data
-- widget
-- name
function Style:createStyleFrom( params )
	-- print( "Style:createStyleFrom", params, params.copy )
	params = params or {}
	if params.copy==nil then params.copy=true end
	--==--
	local data = params.data
	local copy = params.copy ; params.copy=nil

	local StyleClass = self.class
	local style
	if data==nil then
		style = StyleClass:new( params )
	elseif type(data.isa)=='function' then

		if not copy then
			style = data
		else
			style = data:copyStyle( params )
		end
	else
		-- Lua structure
		style = StyleClass:new( params )
	end

	assert( style, "failed to create style" )

	return style
end


--== inherit

-- value should be a instance of Style Class
--
function Style.__setters:inherit( value )
	-- print( "Style.__setters:inherit", value )
	assert( value:isa( self.class ) )
	--==--
	self._inherit = value
end

--== widget

function Style.__getters:widget()
	-- print( "Style.__getters:widget" )
	return self._widget
end
function Style.__setters:widget( value )
	-- print( "Style.__setters:widget", value )
	-- TODO: update to check class, not table
	assert( value==nil or type(value)=='table' )
	self._widget = value
end


-- onPropertyChange
--
function Style.__setters:onPropertyChange( func )
	-- print( "Style.__setters:onPropertyChange", func )
	assert( type(func)=='function' )
	--==--
	self._onPropertyChange_f = func
end


--======================================================--
-- Access to style properties

--[[
override these getters/setters/methods if necesary
--]]

--== name

function Style.__getters:name()
	-- print( 'Style.__getters:name', self._inherit )
	local value = self._name
	if value==nil and self._inherit then
		value = self._inherit.name
	end
	return value
end
function Style.__setters:name( value )
	-- print( 'Style.__setters:name', value )
	assert( (value==nil and self._inherit) or type(value)=='string' )
	--==--
	if value == self._name then return end
	self._name = value
end

--== debugOn

function Style.__getters:debugOn()
	local value = self._debugOn
	if value==nil and self._inherit then
		value = self._inherit.debugOn
	end
	return value
end
function Style.__setters:debugOn( value )
	-- print( "Style.__setters:debugOn", value )
	assert( type(value)=='boolean' or (value==nil and self._inherit) )
	--==--
	if value == self._debugOn then return end
	self._debugOn = value
	self:_dispatchChangeEvent( 'debugOn', value )
end

--== X

function Style.__getters:x()
	local value = self._x
	if value==nil and self._inherit then
		value = self._inherit.x
	end
	return value
end
function Style.__setters:x( value )
	-- print( "Style.__setters:x", value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	if value == self._x then return end
	self._x = value
	self:_dispatchChangeEvent( 'x', value )
end

--== Y

function Style.__getters:y()
	local value = self._y
	if value==nil and self._inherit then
		value = self._inherit.y
	end
	return value
end
function Style.__setters:y( value )
	-- print( "Style.__setters:y", value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	if value == self._y then return end
	self._y = value
	self:_dispatchChangeEvent( 'y', value )
end

--== width

function Style.__getters:width()
	-- print( "Style.__getters:width", self.name, self._width  )
	local value = self._width
	if value==nil and self._inherit then
		value = self._inherit.width
	end
	return value
end
function Style.__setters:width( value )
	-- print( "Style.__setters:width", self.name, value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	if value == self._width then return end
	self._width = value
	self:_dispatchChangeEvent( 'width', value )
end

--== height

function Style.__getters:height()
	local value = self._height
	if value==nil and self._inherit then
		value = self._inherit.height
	end
	return value
end
function Style.__setters:height( value )
	-- print( "Style.__setters:height", value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	if value == self._height then return end
	self._height = value
	self:_dispatchChangeEvent( 'height', value )
end


--== align

function Style.__getters:align()
	local value = self._align
	if value==nil and self._inherit then
		value = self._inherit.align
	end
	return value
end
function Style.__setters:align( value )
	-- print( 'Style.__setters:align', value )
	assert( type(value)=='string' or (value==nil and self._inherit) )
	--==--
	if value==self._align then return end
	self._align = value
	self:_dispatchChangeEvent( 'align', value )
end

--== anchorX

function Style.__getters:anchorX()
	local value = self._anchorX
	if value==nil and self._inherit then
		value = self._inherit.anchorX
	end
	return value
end
function Style.__setters:anchorX( value )
	-- print( 'Style.__setters:anchorX', value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	if value==self._anchorX then return end
	self._anchorX = value
	self:_dispatchChangeEvent( 'anchorX', value )
end

--== anchorY

function Style.__getters:anchorY()
	local value = self._anchorY
	if value==nil and self._inherit then
		value = self._inherit.anchorY
	end
	return value
end
function Style.__setters:anchorY( value )
	-- print( 'Style.__setters:anchorY', value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	if value==self._anchorY then return end
	self._anchorY = value
	self:_dispatchChangeEvent( 'anchorY', value )
end

--== fillColor

function Style.__getters:fillColor()
	local value = self._fillColor
	if value==nil and self._inherit then
		value = self._inherit.fillColor
	end
	return value
end
function Style.__setters:fillColor( value )
	-- print( "Style.__setters:fillColor", value )
	assert( value or (value==nil and self._inherit) )
	--==--
	self._fillColor = value
	self:_dispatchChangeEvent( 'fillColor', value )
end

--== font

function Style.__getters:font()
	local value = self._font
	if value==nil and self._inherit then
		value = self._inherit.font
	end
	return value
end
function Style.__setters:font( value )
	-- print( "Style.__setters:font", value )
	assert( value or (value==nil and self._inherit) )
	--==--
	self._font = value
	self:_dispatchChangeEvent( 'font', value )
end

--== fontSize

function Style.__getters:fontSize()
	local value = self._fontSize
	if value==nil and self._inherit then
		value = self._inherit.fontSize
	end
	return value
end
function Style.__setters:fontSize( value )
	-- print( "Style.__setters:fontSize", value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	self._fontSize = value
	self:_dispatchChangeEvent( 'fontSize', value )
end

--== marginX

function Style.__getters:marginX()
	local value = self._marginX
	if value==nil and self._inherit then
		value = self._inherit.marginX
	end
	return value
end
function Style.__setters:marginX( value )
	-- print( "Style.__setters:marginX", value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	self._marginX = value
	self:_dispatchChangeEvent( 'marginX', value )
end

--== marginY

function Style.__getters:marginY()
	local value = self._marginY
	if value==nil and self._inherit then
		value = self._inherit.marginY
	end
	return value
end
function Style.__setters:marginY( value )
	-- print( "Style.__setters:marginY", value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	self._marginY = value
	self:_dispatchChangeEvent( 'marginY', value )
end

--== strokeColor

function Style.__getters:strokeColor()
	local value = self._strokeColor
	if value==nil and self._inherit then
		value = self._inherit.strokeColor
	end
	return value
end
function Style.__setters:strokeColor( value )
	-- print( "Style.__setters:strokeColor", value )
	assert( value or (value==nil and self._inherit) )
	--==--
	self._strokeColor = value
	self:_dispatchChangeEvent( 'strokeColor', value )
end

--== strokeWidth

function Style.__getters:strokeWidth( value )
	local value = self._strokeWidth
	if value==nil and self._inherit then
		value = self._inherit.strokeWidth
	end
	return value
end
function Style.__setters:strokeWidth( value )
	-- print( "Style.__setters:strokeWidth", value )
	assert( type(value)=='number' or (value==nil and self._inherit) )
	--==--
	if value == self._strokeWidth then return end
	self._strokeWidth = value
	self:_dispatchChangeEvent( 'strokeWidth', value )

end

--== textColor

function Style.__getters:textColor()
	local value = self._textColor
	if value==nil and self._inherit then
		value = self._inherit.textColor
	end
	return value
end
function Style.__setters:textColor( value )
	-- print( "Style.__setters:textColor", value )
	assert( value or (value==nil and self._inherit) )
	--==--
	if value == self._textColor then return end
	self._textColor = value
	self:_dispatchChangeEvent( 'textColor', value )
end



--====================================================================--
--== Private Methods


--======================================================--
-- Style Class setup

-- _prepareData()
-- if necessary, modify data before we process it
-- usually this is to copy styles from parent to child
--
function Style:_prepareData( data )
	-- print("OVERRIDE Style:_prepareData")
	-- data could be nil, Lua structure, or class instance
	if type(data)=='table' and data.isa then
		data=nil
	end
	return data
end

-- _checkChildren()
-- check children after class initialization
-- eg, if a style doesn't have any child properties (eg, background)
-- to actually create the substyle
--
function Style:_checkChildren()
	-- print("OVERRIDE Style:_checkChildren")
end

-- _checkProperties()
-- ability to check properties to make sure everything went well
--
function Style:_checkProperties()
	-- print( "Style:_checkProperties" )
	local emsg = "Style: requires property '%s'"
	local is_valid = true

	if not self.name then print(sformat(emsg,'name')) ; is_valid=false end
	if self.debugOn==nil then print(sformat(emsg,'debugOn')) ; is_valid=false end
	return is_valid
end

-- _parseData()
-- parse through the Lua data given, creating properties
-- an substyles as we loop through
--
function Style:_parseData( data )
	-- print( "Style:_parseData", data )
	if data==nil then return end

	-- prep tables of things to exclude, etc
	local DEF = self._STYLE_DEFAULTS
	local EXCL = self.EXCLUDE_PROPERTY_CHECK

	for k,v in pairs( data ) do
		-- print(k,v)
		if DEF[k]==nil and not EXCL[k] then
			error( sformat( "Style: invalid property style found '%s'", tostring(k) ) )
		end
		self[k]=v
	end
end


--======================================================--
-- Event Dispatch

-- _dispatchResetEvent()
-- send out Reset event to listeners
--
function Style:_dispatchResetEvent()
	-- print( 'Style:_dispatchResetEvent', self )
	--==--
	local widget = self._widget
	local callback = self._onPropertyChange_f

	if not widget and not callback then return end

	local e = {
		name=self.EVENT,
		target=self,
		type=self.STYLE_RESET
	}
	if widget and widget.stylePropertyChangeHandler then
		widget:stylePropertyChangeHandler( e )
	end
	if callback then callback( e ) end
end


-- _dispatchChangeEvent()
-- send out property-changed event to listeners
--
function Style:_dispatchChangeEvent( prop, value, substyle )
	-- print( 'Style:_dispatchChangeEvent', prop, value, self )
	local widget = self._widget
	local callback = self._onPropertyChange_f

	if not widget and not callback then return end

	local e = {
		name=self.EVENT,
		target=self,
		type=self.STYLE_UPDATED,
		property=prop,
		value=value
	}
	if widget and widget.stylePropertyChangeHandler then
		widget:stylePropertyChangeHandler( e )
	end
	if callback then callback( e ) end

end



--====================================================================--
--== Event Handlers


-- none



return Style
