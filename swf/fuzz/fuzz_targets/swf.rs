#![no_main]
use libfuzzer_sys::fuzz_target;

fuzz_target!(|data: &[u8]| {
    if let Ok(swfbuf) = swf::decompress_swf(data) {
        let _ = swf::parse_swf(&swfbuf);
    }
});
