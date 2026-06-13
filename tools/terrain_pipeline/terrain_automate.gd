# terrain_automate.gd — Automated sculpt & paint for Terrain3D
# Place this file in res://tools/terrain_pipeline/ and run via "Tools ▶︎ Run Editor Script"

@tool
extends EditorScript

func _run():
    var scene_path := "res://scenes/world/Main.tscn"
    var scene := ResourceLoader.load(scene_path).instantiate()
    if not scene:
        printerr("[TerrainAutomate] Failed to load scene: %s" % scene_path)
        return

    var terrain := scene.get_node("Terrain3D")
    if not terrain:
        printerr("[TerrainAutomate] Terrain3D node not found")
        return

    # Phase 1: Heightmap import scale & bake
    if terrain.has_method("set_import_scale"):
        terrain.set_import_scale(0.04)
    terrain.height_offset = 0.0
    # Reimport/bake the heightmap mesh
    if terrain.has_method("bake_imported"):
        terrain.bake_imported()

    # Phase 2: Sculpt pass — core flatten, driveway, boundary rim
    var core_center := Vector3(0, 0, 0)
    terrain.sculpt_flat(core_center, 50.0)
    # carve driveway
    var start := Vector3(-500, 0, -300)
    var end := Vector3(500, 0, -300)
    terrain.sculpt_flat_line(start, end, 20.0)
    # raise boundary rim
    terrain.sculpt_raise_border(500.0, 50.0)

    # Phase 3: Paint pass & material setup
    var mat := terrain.material as TerrainMaterial
    if mat:
        # configure low-res layers
        mat.set_layer_texture(0, load("res://assets/lowres/grass_256.png"))
        mat.set_layer_texture(1, load("res://assets/lowres/dirt_256.png"))
        mat.set_layer_texture(2, load("res://assets/lowres/mud_256.png"))
        mat.set_layer_texture(3, load("res://assets/lowres/asphalt_256.png"))
        # nearest filtering
        for i in mat.get_layer_count():
            mat.get_layer(i).filter = Texture.FILTER_NEAREST
    # flood grass
    terrain.paint_layer_rectangle(-500, -500, 1000, 1000, 0)
    # path painting
    terrain.paint_line(start, end, 1)
    # AO shadow painting under objects — for demo, paint a ring
    terrain.paint_border_layers(2, 500.0, 30.0)

    # Phase 4: Collision & LOD
    terrain.collision_enabled = true
    # set simple LOD distances (low-poly style)
    terrain.lod_far_distance = 1000.0
    terrain.lod_near_distance = 200.0

    # Save changes
    var err := ResourceSaver.save(scene_path, scene)
    if err != OK:
        printerr("[TerrainAutomate] Failed saving scene: %s" % err)
    else:
        print("[TerrainAutomate] Terrain sculpt & paint complete")
