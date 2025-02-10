var dx = 0, dy = 0;

running = false;

if (casting_frame == 0) {
    if (!talking) {
        if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
            dx = -1;
        }
        if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
            dx = 1;
        }
        if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
            dy = -1;
        }
        if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
            dy = 1;
        }
        if (keyboard_check(ord("C"))) {
            casting_frame = sprite_get_number(spr_duckling_cast) / 4;
        }
    }
    
    if (dx != 0 || dy != 0) {
        var mag = point_distance(0, 0, dx, dy);
        if (keyboard_check(vk_shift)) {
            running = true;
            mag /= 1.5;
        }
        dx /= mag;
        dy /= mag;
        anim_frame = (anim_frame + 0.125) % 4;
        anim_dir = point_direction(0, 0, dx, dy) / 90;
    } else {
        anim_frame = 0;
    }
    
    x += dx * 2;
    y += dy * 2;
    
    if (keyboard_check_pressed(vk_space) && !talking) {
        var facing = collision_point(x + 24 * dcos(anim_dir * 90), y - 24 * dsin(anim_dir * 90), par_thingy, false, true);
        if (facing) {
            talking = facing;
            talking_t = 0;
        }
        audio_play_sound(se_coin, 110, false);
    }
    
    if (dx != 0 || dy != 0) {
        if (!audio_is_playing(se_footstep)) {
            audio_play_sound(se_footstep, 100, false);
        }
    }
} else {
    casting_frame = max(0, casting_frame - 0.25);
}
/*
if (keyboard_check_pressed(ord("P"))) {
    var save_data = {
        x: obj_player.x,
        y: obj_player.y,
        dir: obj_player.anim_dir
    };
    var save_json = json_stringify(save_data);
    var buffer = buffer_create(1, buffer_grow, 1);
    buffer_write(buffer, buffer_text, save_json);
    buffer_save(buffer, "save.dat");
    buffer_delete(buffer);
}

if (keyboard_check_pressed(ord("O"))) {
    if (file_exists("save.dat")) {
        var buffer = buffer_load("save.dat");
        var save_json = buffer_read(buffer, buffer_text);
        var save_data = json_parse(save_json);
        buffer_delete(buffer);
        
        with (obj_player) {
            x = save_data.x;
            y = save_data.y;
            anim_dir = save_data.dir;
        }
    }
}
*/
if (keyboard_check_pressed(ord("P"))) {
    var save_data = {
        x: obj_player.x,
        y: obj_player.y,
        dir: obj_player.anim_dir
    };
    var save_json = json_stringify(save_data);
    var buffer = buffer_create(1, buffer_grow, 1);
    buffer_write(buffer, buffer_text, save_json);
    buffer_async_group_begin("duck");
    buffer_save_async(buffer, "save.dat", 0, buffer_get_size(buffer));
    save_buffer_async_id = buffer_async_group_end();
    buffer_delete(buffer);
}

if (keyboard_check_pressed(ord("O"))) {
    load_buffer = buffer_create(100, buffer_grow, 1);
    buffer_async_group_begin("duck");
    buffer_load_async(load_buffer, "duck/save.dat", 0, -1);
    load_buffer_async_id = buffer_async_group_end();
}