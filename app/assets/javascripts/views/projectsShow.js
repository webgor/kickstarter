App.Views.ProjectsShow = Backbone.View.extend({
  template: JST["project/show"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var view = this;
    var renderedContent = this.template({
      project: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});