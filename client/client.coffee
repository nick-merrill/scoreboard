Router.configure {
  layoutTemplate: 'layout'
}


Router.map ->
  this.route 'home', {
    path: '/'
    template: 'main'
    data: -> {
      teams: Teams.find()
    }
  }

  this.route 'edit', {
    path: '/edit'
    template: 'main'
    data: -> {
      teams: Teams.find()
      edit: true
    }
  }


getTeamId = (event) ->
  $target = $(event.target)
  $team = $target.closest('.team')
  return $team.attr('data-id')

Template.main.events {

  'click .add': (e) ->
    Teams.insert {name: "", score: 0}

  'click .team .up': (e) ->
    Teams.update {_id: getTeamId(e)}, {
      $inc: {'score': 1}
    }
  'click .team .down': (e) ->
    Teams.update {_id: getTeamId(e)}, {
      $inc: {'score': -1}
    }

  'click .team .remove': (e) ->
    Teams.remove {_id: getTeamId(e)}

  'input .team input.name': (e) ->
    Teams.update {_id: getTeamId(e)}, {
      $set: {'name': $(e.target).val()}
    }
}
