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
		ShootBullets(mouseX + 25);
		GenerateAllObstacles();
		DrawObstacles();
		UpdateBullets();
		UpdateScore();
		DrawScore();
	} else {
		DrawOpeningScreen();
	}
	if(bullets != null && obstacles != null){
		println("Bullets Length: " + bullets.length + "     Obstacles length: " + obstacles.length);		
	}

}


void mousePressed() {
	if(GameIsRunning === false) {
		GameIsRunning = true;
	}
}

var CreateObstacles = function() {
	var obstacle = [];
	obstacle.x = random(50, stageWidth - 50);
	obstacle.y = 0;
	obstacle.ySpeed = 0.1 + random(2);
	obstacle.type = "obstacle";

	return obstacle;
};

var GenerateAllObstacles = function() {
	// Wait for the next round to be chambered
    if (frameCount - lastObstacleCreation < 500) {
        return;
    }
	var numObstacles = random(9);
	for(var i = 0; i < numObstacles; i++) {
		obstacles.push(CreateObstacles());
	}
	lastObstacleCreation = frameCount;
};

var ShootBullets = function(posX) {
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

	bullets.push(bullet);

	player.lastFired = frameCount;
};

var DrawOpeningScreen = function() {
	fill(255,255,255);
    text("Click to start the game", 300, 220);
};

var DrawObstacles = function() {
	for(var i = 0; i < obstacles.length; i++) {
		rect(obstacles[i].x, obstacles[i].y, 30, 30);
		obstacles[i].y += obstacles[i].ySpeed;

		if(obstacles[i].y >= stageHeight) {
			obstacles.splice(i,1);
		}
	}
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

var UpdateScore = function() {
	for(var i = 0; i < bullets.length; i++) {
		for(var n = 0; n < obstacles.length; n++) {
			if(bullets[i].x == obstacles[n].x && bullets[i].y == obstacles[n].y) {
				player.score++;
			}
		}	
	}
};

var DrawScore = function() {
	fill(255,255,255);
    text("Score: " + player.score, 300, 20);
}