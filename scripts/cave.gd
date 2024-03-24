extends StaticBody2D

@export var pathPath : NodePath
@export var collisionPolyPath : NodePath
@export var colorPolyPath : NodePath

@export var max_stages : int = 10
@export var tolerance_length : float = 1.0

var pathNode : Path2D
var collisionPolyNode : CollisionPolygon2D
var colorPolyNode : Polygon2D

func _ready():
	pathNode = get_node(pathPath)
	collisionPolyNode = get_node(collisionPolyPath)
	colorPolyNode = get_node(colorPolyPath)
	
	var polygon : PackedVector2Array = pathNode.curve.tessellate(max_stages, tolerance_length)
	
	collisionPolyNode.polygon = polygon
	colorPolyNode.polygon = polygon
