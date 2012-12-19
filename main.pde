var rectY = 0;
var playing = false;
var objects;
var stageWidth = 800;
var stageHeight = 600;

void setup() {
	size(stageWidth,stageHeight);
	
	fill(255,255,255);
	
	PFont fontA = loadFont("courier");
  	textFont(fontA, 14);
}

void draw() {
	background(0,0,0);

	if(playing === true) {
		for(var i = 0; i < objects.length; i++) {
			if(objects[i].type == "bullet") {
				rect(objects[i].x, objects[i].y, 5, 5);
				objects[i].y -= objects[i].ySpeed;
			} else {
				objects[i].y += objects[i].ySpeed;
				rect(objects[i].x, objects[i].y, 30, 30);
			}
		}
	} else {
		fill(255,255,255);
		textAlign(160, 220);        
        text("Click to start the game");
	}
	
	rect(mouseX, stageHeight - 50, 50, 10);

	if(playing === true && mousePressed) {
		ShootBullets(mouseX + 25);
	}
	//println(objects[0].x);
}

var CreateObstacles = function() {
	var obstacle = [];
	obstacle.x = random(50, stageWidth - 50);
	obstacle.y = 0;
	obstacle.ySpeed = 0.1 + random(5);
	obstacle.type = "obstacle";
	//obstacle.gravity = 0.1 + random(5);

	return obstacle;
};

void mousePressed() {
	if(playing === false) {
		playing = true;
		for(var i = 0; i < 1000; i++) {}
		GenerateAllObstacles();
	}
}

function GenerateAllObstacles() {
	objects = [];
	var numObstacles = random(9);
	for(var i = 0; i < numObstacles; i++) {
		objects.push(CreateObstacles());
	}
}

function ShootBullets(posX) {
	var bullet = [];
	bullet.x = posX;
	bullet.y = stageHeight - 50;
	bullet.ySpeed = 5;
	bullet.type = "bullet";

	objects.push(bullet);
}
