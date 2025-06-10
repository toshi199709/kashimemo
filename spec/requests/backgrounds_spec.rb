require 'rails_helper'

RSpec.describe "Backgrounds", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe "PATCH /background" do
    it "背景画像をアップロードして保存できる" do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.jpg'), 'image/jpeg')

      patch background_path, params: {
        user: {
          background_image: file,
          background_opacity: 80
        }
      }

      user.reload
      expect(user.background_image).to be_attached
      expect(user.background_opacity).to eq(80)
    end

    it "背景画像を削除できる" do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.jpg'), 'image/jpeg')
      user.background_image.attach(file)

      patch background_path, params: { remove_background: true }

      user.reload
      expect(user.background_image).not_to be_attached
    end
  end
end
