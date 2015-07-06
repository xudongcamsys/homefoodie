class InvitesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find params[:user_id]

    @invites = @user.invites
  end

  def create
    @event = Event.find params[:event_id]
    @invitee = User.find params[:invitee_id]

    @event.invite! @invitee

    redirect_to :back
  end

  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    redirect_to :back
  end

  def accept
    @invite = Invite.find(params[:invite_id])

    @invite.invitee.accept_invitation! @invite

    redirect_to :back
  end
end
