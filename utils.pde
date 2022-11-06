boolean isColliding(Circle circle, Circle otherCircle) {
    PVector other = otherCircle.location;
    PVector location = circle.location;
    
    return location.dist(other) < circle.rad + otherCircle.rad;
}

Circle generateRandomCircle(int index, int thisCollidingCount,PeasyGradients p) {
    int radius = 20;
    
    PVector randomPoint = new PVector(floor(random(width - radius * 2)), floor(random(height - radius * 2)));
    Circle randomCircle = new Circle(randomPoint, radius, p);
    
    for (int i = 0; i < index; i ++) {
        if (isColliding(randomCircle,circles[i])) {
            thisCollidingCount ++;
            print("collide ", thisCollidingCount,"\n");
            return generateRandomCircle(index, thisCollidingCount,p);
        }
    }
    
    if (thisCollidingCount > 0) {
        print("no collide returning points ", randomPoint.x , randomPoint.y,"\n");
    }
    
    return randomCircle;
}