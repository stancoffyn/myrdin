class MyrdinkeysController < ApplicationController
  skip_before_action :verify_key, only: [:new_install]

  def index
    if master_or_core?
      render json: { state: 'SUCCESS', data: Apikey.all }, status: :ok
    else
      unauthorized!
    end
  end

  def new_install
    key_exists = Apikey.core.exists?

    if key_exists
      render json: { state: 'ERROR', data: 'API KEY EXISTS' }
    else
      key_result, key = Apikey.create_core_key
      render json: { state: key_result ? 'SUCCESS' : 'ERROR', data:
                  key.token }, status: key_result ? :ok : :internal_server_error
    end
  end

  def create
    if master_or_core?
      new_token = Apikey.new(myrdin_create_key_params) do |mk|
        mk.token = SecureRandom.hex(10)
      end
      new_token.save
      render json: { state: 'SUCCESS', data: new_token }, status: :ok
    else
      unauthorized!
    end
  end

  def update
    if master_or_core?
      ps = myrdin_update_key_params
      @existing = Apikey.find(params[:id])
      @existing.update_attributes(ps)
      @existing.save
      render json: { state: 'SUCEESS', data: @existing }, status: :ok
    else
      unauthorized!
    end
  end

  def destroy
    if master_or_core?
      Apikey.destroy(params[:id])
      render json: { state: 'SUCCESS' }, status: :ok
    else
      unauthorized!
    end
  end

  def myrdin_create_key_params
    params.require(:key).permit(:active, :auth_type)
  end

  def myrdin_update_key_params
    params.require(:key).permit(:active)
  end
end
