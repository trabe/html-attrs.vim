require 'spec_helper'

describe 'HtmlAttrsAddClass' do
  include FileHelpers

  include_examples 'restores state'

  context 'within an empty tag' do
    before do
      write_file 'test.html', <<-EOF
        <span>
          @
        </span>
      EOF
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

    specify 'adds a class attribute to the right tag' do

      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddClass'

      vim.insert 'class'
      vim.write

      expected =  <<-EOF
        <p class="class">
          <span>
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

    specify 'adds a class attribute' do

      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddClass'

      vim.insert 'class'
      vim.write

      expected =  <<-EOF
        <span class="class" title="some @title">
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end
  end

  context 'when the opening tag spans multiple lines' do
    specify 'appends to an existing class attribute' do
      write_file 'test.html', <<-EOF
        <span
          title="my title"
          class="test">
          @
        </span>
      EOF

      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddClass'

      vim.insert 'class '
      vim.write

      expected =  <<-EOF
        <span
          title="my title"
          class="class test">
          @
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end

    specify 'adds a class attribute if none exists' do
      write_file 'test.html', <<-EOF
        <span
          title="my title"
          class="test">
          @
        </span>
      EOF

      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddClass'

      vim.insert 'class '
      vim.write

      expected =  <<-EOF
        <span
          title="my title"
          class="class test">
          @
        </span>
      EOF

      normalized('test.html').should eq normalize_string_indent(expected)
    end
  end
end
