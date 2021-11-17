# frozen_string_literal: true

module BooksHelper
  def t_attr(str)
    Book.human_attribute_name(str)
  end
end
