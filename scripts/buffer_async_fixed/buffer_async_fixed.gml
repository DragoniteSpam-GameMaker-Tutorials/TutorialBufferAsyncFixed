global.buffer_asink_stuff = { };

function buffer_save_asink(buffer, filename, offset, size, callback) {
    var save_id = buffer_save_async(buffer, filename, offset, size);
    global.buffer_asink_stuff[$ string(save_id)] = {
        callback: callback,
        type: "save"
    };
}

function buffer_load_asink(filename, offset, size, callback) {
    
}

function buffer_asink_deal_with_all_of_it(async_id, status) {
    
}