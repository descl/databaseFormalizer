// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function remove_attrlistvalues(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".attrlistparam").hide();
}
function add_attrlistvalues(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}