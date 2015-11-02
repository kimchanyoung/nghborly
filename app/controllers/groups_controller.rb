class GroupsController < ApplicationController
  def inquire
  end

  def assign
    user = current_user

    group = find_group(params[:address])

    user.group_id = group.id

    if user.save
      redirect_to root_path
    else
      flash[:now] = "We couldn't assign you to a building!"
      render :inquire
    end
  end

  private

  def find_group(address_hash)
    normalized_address_params = normalize_address_params(params[:address])
    Group.find_or_create_by(normalized_address_params)
  end

  def normalize_address_params(address_hash)
    base_api_endpoint = URI("https://api.smartystreets.com/street-address")

    secrets = {'auth-id' =>  ENV['SMARTY_STREETS_AUTH_ID'], 'auth-token' => ENV['SMARTY_STREETS_AUTH_TOKEN']}

    query = secrets.merge(address_hash)

    base_api_endpoint.query = URI.encode_www_form(query)

    api_response = Net::HTTP.get_response(base_api_endpoint)

    results = JSON.parse(api_response.body)

    clean_results(results.first["components"])
  end

  def clean_results(hash)
    unnecessary_keys = %w(plus4_code delivery_point delivery_point_check_digit)

    unnecessary_keys.each { |key| hash.delete(key) }

    hash
  end
end
