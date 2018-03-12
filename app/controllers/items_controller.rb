class ItemsController < ApplicationController
  before_action :require_user_logged_in

  def new
    @items = [] #配列

    @keyword = params[:keyword]
    if @keyword.present? # 
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })

      results.each do |result|
        # 扱い易いように Item としてインスタンスを作成する（保存はしない）
        item = Item.find_or_initialize_by(read(result)) #read(result) のユーザが存在する場合は取得(find)、しなければ新規作成(未保存)
        @items << item  #左辺の配列（レシーバ）の末尾に右辺のオブジェクトを要素として加えます。
      end
    end
  end

  private

  def read(result)
    code = result['itemCode']
    name = result['itemName']
    url = result['itemUrl']
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '') #画像 URL 末尾に含まれる ?_ex=128x128 を削除

    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end