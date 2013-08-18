html-attrs.vim
==============

A simple plugin to add or modify HTML tags attributes

**WARNING!**

This is a work in progress. Right now it is a lame and stupid plugin.

How it works
------------

The idea is quite simple: when editing some HTML code I usually need to add an **id** or tweak a CSS **class**.

While inside an HTML tag I want to be able to:

  * Add an *id* attribute or change it if it exists
  * Add a **class** attribute or change it if it exists

### Examples

In the following examples the "|" character represents the current cursor
position.

Given:

    <span>some text|</span>

Run the `HtmlAttrsAddId` command and you get:

    <span id="|">some text</span>

Given:

    <span id="my-id">some text|</span>

Run the `HtmlAttrsAddId` command and you get:

    <span id="|my-id">some text</span>

Given:

    <span class="my-class other-class">some text|</span>

Run the `HtmlAttrsAddClass` command and you get:

    <span class="|my-class other-class">some text</span>

Given:

    <span>some text|</span>

Run the `HtmlAttrsAddClass` command and you get:

    <span class="|">some text</span>

### Options

The only available option right now is `html_attrs_remove_existing_id`.
When set to `1` (it defaults to `0`) the `HtmlAttrsAddId` command will
replace the existing `id` (if any).

So, given:

    <span id="my-id">some text|</span>

Running the `HtmlAttrsAddId` command will give you:

    <span id="|">some text</span>

### Handling nested tags

The plugin uses tag text objects for finding the tag start, so given:

    <p>
      <span>
      </span>
      |
    </p>

After running the `HtmlAttrsAddId` command you get:

    <p id="|">
      <span>
      </span>
    </p>

Specs
-----

The plugin has a set of specs written in Ruby using Rspec + [vimrunner](https://github.com/AndrewRadev/vimrunner).

In order to test the plugin (assuming you have got Ruby and Bundler installed):

  1. Run `bundle install`
  2. Run `rspec`

TODO
----

See the [issues](https://github.com/trabe/html-attrs.vim/issues).


License
-------

[MIT](http://opensource.org/licenses/MIT)
