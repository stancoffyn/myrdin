class CharactersController < ApplicationController
  def index
    render json: Character.all
  end

  def create
    if master_or_core? || raid_leader?
      new_character = Character.new(character_params)
      new_character.save
      render json: new_character
    else
      unauthorized!
    end
  end

  def update
    if master_or_core? || raid_leader?
      ps = character_params
      character = Character.find(params[:id])
      character.update_attributes(ps)
      character.save
      render json: {state: 'SUCCESS', data: character }, status: :ok
    else
      unauthorized!
    end
  end

  def destroy
    if master_or_core? || raid_leader?
      Character.destroy(params[:id])
      render json: {state: 'SUCESS'}, status: :ok
    else
      unauthorized!
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :character_class_type, :level, :last_online)
  end
end
 