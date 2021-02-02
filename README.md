# neovim-ui

neovim-ui is a semi-official prototype for what will become neovim's new UI module. This effort
was started because it was observed that numerous plugin authors were duplicating the same
boilerplate code while creating UI elements. This not only increases duplication of effort,
but leads to inconsistent UI elements across plugins. The goal of this module is to:

* Provide a cohesive set of UI elements that work well together
* Support internal neovim UI elements that have arisen on an "as-needed" basis
* Make UI easy to use, to encourge more plugins to take advantage of neovim's UI system

## Install

* Requires [Neovim HEAD/nightly](https://github.com/neovim/neovim/releases/tag/nightly) (v0.5 prerelease).

* Install neovim-ui as a plugin. For [vim-plug](https://github.com/junegunn/vim-plug):
  ```
  :Plug 'mjlbach/neovim-ui'
  ```
