require 'spec_helper'

describe 'HtmlAttrs' do
  include FileHelpers

  context 'within an empty tag' do
    before do
      write_file 'test.html', <<-EOF
        <span>
          @
        </span>
      EOF
    end

    specify 'adds an id attribute' do

      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddId'

      # should be:
      #
      #   vim.type 'id<Esc>'
      #
      # but... it does not work :(

      vim.insert 'id'
      vim.write

      expected =  <<-EOF
        <span id="id">
          @
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end

    specify 'adds a class attribute' do
      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddClass'

      vim.insert 'class'
      vim.write

      expected =  <<-EOF
        <span class="class">
          @
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end

  end

  context 'within a tag with an id' do
    before do
      write_file 'test.html', <<-EOF
        <span id="my-id">
          @
        </span>
      EOF
    end

    specify 'extends the id attribute' do
      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddId'

      vim.insert 'new-'
      vim.write

      expected =  <<-EOF
        <span id="new-my-id">
          @
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end

    specify 'adds a class attribute' do
      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddClass'

      vim.insert 'new-class'
      vim.write

      expected =  <<-EOF
        <span class="new-class" id="my-id">
          @
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end
  end

  context 'within a tag with a class' do
    before do
      write_file 'test.html', <<-EOF
        <span class="my-class">
          @
        </span>
      EOF
    end

    specify 'adds the id attribute' do
      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddId'

      vim.insert 'my-id'
      vim.write

      expected =  <<-EOF
        <span id="my-id" class="my-class">
          @
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end

    specify 'extends the class attribute' do
      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddClass'

      vim.insert 'new-class '
      vim.write

      expected =  <<-EOF
        <span class="new-class my-class">
          @
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end
  end

  context 'with many tags' do
    before do
      write_file 'test.html', <<-EOF
        <p>
          <span>
          </span>
          @
        </p>
      EOF
    end

    specify 'adds an id attribute to the closest tag' do

      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddId'

      vim.insert 'id'
      vim.write

      expected =  <<-EOF
        <p>
          <span id="id">
          </span>
          @
        </p>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end
  end

  context 'inside the opening tag' do
    before do
      write_file 'test.html', <<-EOF
        <span title="some @title">
        </span>
      EOF
    end

    specify 'adds an id attribute' do

      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddId'

      vim.insert 'id'
      vim.write

      expected =  <<-EOF
        <span id="id" title="some @title">
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end
  end

  context 'when html_attrs_remove_existing_id is enabled' do
    before do
      write_file 'test.html', <<-EOF
        <span id="old-id">
          @
        </span>
      EOF
    end

    specify 'HtmlAttrsAddId removes the existing id' do

      vim.edit 'test.html'
      vim.command 'let g:html_attrs_remove_existing_id=1'
      vim.search '@'
      vim.command 'HtmlAttrsAddId'

      vim.insert 'new-id'
      vim.write

      expected =  <<-EOF
        <span id="new-id">
          @
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end
  end
end
