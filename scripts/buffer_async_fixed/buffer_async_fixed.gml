global.buffer_asink_stuff = { };

function buffer_save_asink(buffer, filename, offset, size, callback) {
    var save_id = buffer_save_async(buffer, filename, offset, size);
    global.buffer_asink_stuff[$ string(save_id)] = {
        callback: callback,
        type: "save",
        buffer: buffer
    };
}

function buffer_load_asink(filename, offset, size, callback) {
    var dest_buffer = buffer_create(1, buffer_grow, 1);
    var load_id = buffer_load_async(dest_buffer, filename, offset, size);
    global.buffer_asink_stuff[$ string(load_id)] = {
        callback: callback,
        type: "load",
        buffer: dest_buffer
    };
}

function buffer_asink_deal_with_all_of_it(async_id, status) {
    if (struct_exists(global.buffer_asink_stuff, string(async_id))) {
        var async_info = global.buffer_asink_stuff[$ string(async_id)];
        async_info.callback(async_info.buffer, status);
    }
}