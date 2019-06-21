class ApplicationController < ActionController::API
  before_action :verify_key

  def initialize
    @myrdin_key
  end

  def verify_key
    api_key = params.require(:api_key).permit(:token)
    # TODO: cache key loading

    @myrdin_key = Apikey.where(token: api_key[:token]).first

    unless @myrdin_key
      unauthorized!
    end
  end

  def unauthorized!
    render json: { status: 'UNAUTHORIZED' }, status: :unauthorized
  end

  def active? #core doesn't care about the active state
    @myrdin_key.core? || @myrdin_key.active
  end

  def master_or_core?
    active? && (@myrdin_key.core? || @myrdin_key.master?)
  end

  def looter?
    active? && (master_or_core? || @myrdin_key.looter?)
  end

  def raid_leader?
    active? && (master_or_core? || @myrdin_key.raid_leader?)
  end

  def view?
    active? && (master_or_core? || @myrdin_key.looter? ||
      @myrdin_key.raid_leader? || @myrdin_key.viewer?)
  end
end
