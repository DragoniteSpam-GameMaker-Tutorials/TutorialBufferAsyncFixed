if (async_load[? "id"] == load_buffer_async_id) {
    if (async_load[? "status"] == false) {
        show_message("oh no, failed to load!!!");
        return;
    }

    var save_json = buffer_read(load_buffer, buffer_text);
    var save_data = json_parse(save_json);
    buffer_delete(load_buffer);
        
    with (obj_player) {
        x = save_data.x;
        y = save_data.y;
        anim_dir = save_data.dir;
    }
}

if (async_load[? "id"] == save_buffer_async_id) {
    if (async_load[? "status"] == false) {
        show_message("oh no, failed to save!!! is your disk full or something?");
        return;
    }
    
    show_debug_message("saved the game successfully");
}