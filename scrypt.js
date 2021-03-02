$(document).ready(
    function() {
        $('.section--title').waypoint(
            function(direction) {
                if (direction == "down") {
                    $('nav').addClass('sticky');
                }
            }, {
                offset: '100px'
            }
        )
    }
)