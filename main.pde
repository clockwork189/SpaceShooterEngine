var rectY = 0;
var playing = false;
var objects;

void setup() {
	size(320,480);
	
	fill(255,255,255);
	
	PFont fontA = loadFont("courier");
  	textFont(fontA, 14); 
}

void draw() {
	background(0,0,0);

	if(playing === true) {

	} else {
		textAlign(CENTER, 0);        
        text("Click to start the game");
	}
	
	//println(obs.x);
}

var CreateObstacles = function() {
	var obstacle;
	obstacle.x = random(320);
	obstacle.y = 0;
	obstacle.ySpeed = 0;
	obstacle.gravity = 0.1 + random(0.4);

	return obstacle;
};

var mousePressed = function() {
	if(playing === false) {
		playing = true;
		objects = [];
		var numObstacles = random(9);
		for(var i = 0; i < numObstacle; i++) {
			objects.push(CreateObstacles());
		}
	}
}
