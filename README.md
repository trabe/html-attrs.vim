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

Everything works OK with a simple tag as in the examples above. But what about
a less contrived example? Well, I am afraid it will not work exactly as you
would expect, but this is just a tiny I-did-it-my-way (and my first one ever!)
plugin, so... :)

As you can see, the plugin knows nothing about tags. It just searches backwards
for an _it-opens-like-a-tag_ string. So, given

    <p>
      <span>
      </span>
      |
    </p>

After running the `HtmlAttrsAddId` command you get:

    <p>
      <span id="|">
      </span>
    </p>

Even though the cursor is "inside" the **p** tag, the plugin finds a match
before the opening **p** and inserts the **id** there.


Options
-------

The plugin has the following options:

  * html\_attrs\_remove\_existing\_id: (defaults to 0) when enabled, existing id, if any, will be removed

Specs
-----

The plugin has a set of specs written in Ruby using Rspec + [vimrunner](https://github.com/AndrewRadev/vimrunner).

In order to test the plugin (assuming you have got Ruby and Bundler installer):

  1. Run `bundle install`
  2. Run `rspec`

TODO
----

See the [issues](/trabe/html-attrs.vim/issues).


License
-------

[MIT](http://opensource.org/licenses/MIT)
