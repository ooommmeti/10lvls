@tool
extends RigidBody2D
class_name Block

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var type_id = 0: set = set_type
@export var shape_id = 0: set = set_shape
@export var gravity_mode = 0: set = set_gravity #0 вниз, 1 вправо, 2 вгору, 3 вліво

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		$CollisionShape2D.scale = self.scale;#примусово виставляємо скейл компонентам
		$Sprite2D.scale = self.scale;
		self.mass *= self.scale.x*self.scale.y;#маса блоків дорівнює їх площі
		#self.scale=Vector2(1.0,1.0)
		pass # Replace with function body.

func set_shape(sh):
	shape_id = sh;
	if shape_id==0:
		var shape = RectangleShape2D.new()
		shape.extents = Vector2(31,31)
		$CollisionShape2D.set_shape(shape)
		$Sprite2D.texture = load("res://icon.png")
	if shape_id==1:
		var shape = CircleShape2D.new()
		shape.radius = 31
		$CollisionShape2D.set_shape(shape)
		$Sprite2D.texture = load("res://roundIcon.png")
	if shape_id==2:
		var shape = ConvexPolygonShape2D.new()
		shape.set_point_cloud(PackedVector2Array([Vector2(31, 31), Vector2(-31, 31), Vector2(0, -31)]))
		$CollisionShape2D.set_shape(shape)
		$Sprite2D.texture = load("res://triangIcon.png")
	
func set_gravity(gr):
	#gravity_mode = gr
	#gravity_scale=0;
	#if gravity_mode==0:
	#	self.set_constant_force(Vector2(0,981*self.mass))
	#if gravity_mode==1:
	#	set_constant_force(Vector2(981*self.mass,0))
	#if gravity_mode==2:
	#	set_constant_force(Vector2(0,-981*self.mass))
	#if gravity_mode==3:
	#	set_constant_force(Vector2(-981*self.mass,0))		
	pass

func set_type(tp):
	type_id = tp;
	gravity_scale=1
	if type_id==1:
		modulate = Color(1,0,0)
	if type_id==2:
		modulate = Color(0,1,0)
	if type_id==0:
		modulate = Color(0,0,1)	
	if type_id==3:
		modulate = Color(0,1,1)	
		gravity_scale=-1

func _input_event(viewport, event, shape_idx):
	if type_id==0:
		if (event is InputEventMouseButton):
			if (event as InputEventMouseButton).pressed:
				queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
