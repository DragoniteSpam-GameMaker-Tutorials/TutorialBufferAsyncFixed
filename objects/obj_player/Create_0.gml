event_inherited();

talking = noone;
talking_t = 0;

running = false;
casting_frame = 0;

if (!audio_is_playing(bgm_idle_with_accordions)) {
    audio_play_sound(bgm_idle_with_accordions, 100, true);
}

load_buffer = -1;
load_buffer_async_id = -1;

save_buffer_async_id = -1;