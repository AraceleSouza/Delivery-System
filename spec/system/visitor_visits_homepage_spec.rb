require 'rails_helper'

describe 'visitor visits home page' do
  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).to have_content 'Sistema de Entregas'
  end
end