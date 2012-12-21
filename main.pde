var rectY = 0;

// Runtime game variable
var GameIsRunning = false;

// Creating game obstacles
var obstacles;
var bullets;
bullets = [];
obstacles = [];
// Setting the height and width of the canvas element
var stageWidth = 800;
var stageHeight = 600;
var lastObstacleCreation = 0;


var NUM_LIVES = 3;

var player = {
	lives: NUM_LIVES,
	x: mouseX,
	y: stageHeight - 50,
	score: 0,
	lastFired: -Infinity,
	lastShield: -Infinity,
	lastCollision: -Infinity
};

void setup() {
	size(stageWidth,stageHeight);
	
	background(0,0,0);
	
	PFont fontA = loadFont("courier");
  	textFont(fontA, 14);
}


void draw() {
	background(0,0,0);
	fill(255,255,255);
	if(GameIsRunning === true) {
		DrawPlayer();
		CreateBullets(mouseX + 25);
		GenerateAllObstacles();
		UpdateObstacles();
		UpdateBullets();
		DrawScore();
		UpdateScore();
	} else {
		DrawOpeningScreen();
	}
}


void mousePressed() {
	if(GameIsRunning === false) {
		GameIsRunning = true;
	}
}

var GenerateAllObstacles = function() {
	// Wait for the next round to be chambered
    if (frameCount - lastObstacleCreation < 100) {
        return;
    }
	var numObstacles = random(9);
	for(var i = 0; i < numObstacles; i++) {
		obstacles.push(CreateObstacles());
	}
	lastObstacleCreation = frameCount;
};

var CreateObstacles = function() {
	var obstacle = [];
	obstacle.x = random(50, stageWidth - 50);
	obstacle.y = 0;
	obstacle.ySpeed = 0.1 + random(2);
	obstacle.health = 1;

	return obstacle;
};

var UpdateObstacles = function() {
	for(var i = 0; i < obstacles.length; i++) {
		var obstacle = obstacles[i];
		rect(obstacle.x, obstacle.y, 30, 30);
		obstacle.y += obstacle.ySpeed;

		if(obstacle.y >= stageHeight || obstacle.health <= 0){
			obstacles.splice(i,1);
			player.score++;
		}
	}
};

var DrawOpeningScreen = function() {
	fill(255,255,255);
    text("Click to start the game", 300, 220);
};

var CreateBullets = function(posX) {
	// Only fire on command
    if (!mousePressed && !keyPressed) {
        return;
    }

    // Wait for the next round to be chambered
    if (frameCount - player.lastFired < 10) {
        return;
    }

	var bullet = [];
	bullet.x = posX;
	bullet.y = stageHeight - 50;
	bullet.ySpeed = 5;
	bullet.type = "bullet";
	bullet.damage = 1;

	bullets.push(bullet);

	player.lastFired = frameCount;
};

var UpdateBullets = function() {
	for(var i = 0; i < bullets.length; i++) {
		ellipse(bullets[i].x, bullets[i].y, 5, 5);
		bullets[i].y -= bullets[i].ySpeed;

		if(bullets[i].y <= 0) {
			bullets.splice(i,1);
		}
	}
};

var DrawPlayer = function() {
	rect(mouseX, stageHeight - 50, 50, 10);
};

var DrawScore = function() {
	fill(255,255,255);
    text("Score: " + player.score, 300, 20);
}

var UpdateScore = function() {
	for(var i = bullets.length - 1; i >= 0; i -= 1) {
		var bullet = bullets[i];

		for(var n = obstacles.length - 1; n >= 0 ; n -= 1) {
			var obstacle = obstacles[n];
			if(bullet.x >= obstacle.x && bullet.x <= obstacle.x + 30 && bullet.y >= obstacle.y &&  bullet.y <= obstacle.y + 30) {
				obstacle.health -= bullet.damage;
				bullets.splice(i,1);
			}
		}	
	}
};