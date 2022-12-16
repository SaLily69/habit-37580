require 'rails_helper'
describe GoalsController, type: :request do

  before do
    @user = FactoryBot.create(:user)
    @goal = FactoryBot.create(:goal)
    @log = FactoryBot.create(:log)
  end

  describe "GET #index" do

    context 'ログインしている場合' do
      before do
        sign_in @user
      end

      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        get root_path
        expect(response.status).to eq 200
      end
      #it 'indexアクションにリクエストするとレスポンスに設定済の学習テーマが存在する' do
        #get goals_path
        #expect(response.body).to include(@goal.theme)
      #end
      #it 'indexアクションにリクエストするとレスポンスに投稿済の学習記録が存在する' do
      #end
      #it 'indexアクションにリクエストすると@achievment_rateが含まれている' do
      #end
    end

  end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get root_path
        expect(response.status).to eq 302
      end
    end
end
