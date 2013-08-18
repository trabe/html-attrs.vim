shared_examples 'restores state' do
  context 'after a successful call' do
    specify 'restores the visual block selection marks' do
      pending
    end
  end

  context 'after a failed call' do
    specify 'restores the visual block selection marks' do
      pending
    end

    specify 'restores the cursor pos' do
      write_file 'test.html', <<-EOF
        this
        has
        no
        @
        HTML
      EOF

      vim.edit 'test.html'
      vim.search '@'
      vim.command 'HtmlAttrsAddClass'

      # use the inserted text to test for
      # cursor position...
      vim.insert "=> "

      vim.write

      expected =  <<-EOF
        this
        has
        no
        => @
        HTML
      EOF


      normalized('test.html').should eq normalize_string_indent(expected)

    end
  end
end
