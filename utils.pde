boolean isColliding(Circle circle, Circle otherCircle) {
    Point other = otherCircle.center;
    Point center = circle.center;
    
    return dist(center.x, center.y, other.x, other.y) < circle.rad + otherCircle.rad;
}

Circle generateRandomCircle(int index, int thisCollidingCount,PeasyGradients p) {
    int radius = 20;
    
    Point randomPoint = new Point(floor(random(width - radius * 2)), floor(random(height - radius * 2)));
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