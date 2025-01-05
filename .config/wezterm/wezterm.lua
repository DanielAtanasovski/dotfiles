-- This is the main config for lua
local wezterm = require 'wezterm';
local custom = require 'custom';
local config = wezterm.config_builder();
custom.apply(config);
return config;
