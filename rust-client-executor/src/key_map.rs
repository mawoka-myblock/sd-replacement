use std::thread::sleep;
use std::time::Duration;
use inputbot::{KeybdKey::*, MouseButton::*, *};

pub fn press_key(key: String) {
    let key_to_match: String = key.to_lowercase();
    match key_to_match.as_str() {
        "backspace" => { KeybdKey::BackspaceKey.press() }
        "tab" => { KeybdKey::TabKey.press() }
        "enter" => { KeybdKey::EnterKey.press() }
        "escape" => { KeybdKey::EscapeKey.press() }
        "space" => { KeybdKey::SpaceKey.press() }
        "home" => { KeybdKey::HomeKey.press() }
        "left" => { KeybdKey::LeftKey.press() }
        "up" => { KeybdKey::UpKey.press() }
        "right" => { KeybdKey::RightKey.press() }
        "down" => { KeybdKey::DownKey.press() }
        "insert" => { KeybdKey::InsertKey.press() }
        "delete" => { KeybdKey::DeleteKey.press() }
        "numrow0" => { KeybdKey::Numrow0Key.press() }
        "numrow1" => { KeybdKey::Numrow1Key.press() }
        "numrow2" => { KeybdKey::Numrow2Key.press() }
        "numrow3" => { KeybdKey::Numrow3Key.press() }
        "numrow4" => { KeybdKey::Numrow4Key.press() }
        "numrow5" => { KeybdKey::Numrow5Key.press() }
        "numrow6" => { KeybdKey::Numrow6Key.press() }
        "numrow7" => { KeybdKey::Numrow7Key.press() }
        "numrow8" => { KeybdKey::Numrow8Key.press() }
        "numrow9" => { KeybdKey::Numrow9Key.press() }
        "a" => { KeybdKey::AKey.press() }
        "b" => { KeybdKey::BKey.press() }
        "c" => { KeybdKey::CKey.press() }
        "d" => { KeybdKey::DKey.press() }
        "e" => { KeybdKey::EKey.press() }
        "f" => { KeybdKey::FKey.press() }
        "g" => { KeybdKey::GKey.press() }
        "h" => { KeybdKey::HKey.press() }
        "i" => { KeybdKey::IKey.press() }
        "j" => { KeybdKey::JKey.press() }
        "k" => { KeybdKey::KKey.press() }
        "l" => { KeybdKey::LKey.press() }
        "m" => { KeybdKey::MKey.press() }
        "n" => { KeybdKey::NKey.press() }
        "o" => { KeybdKey::OKey.press() }
        "p" => { KeybdKey::PKey.press() }
        "q" => { KeybdKey::QKey.press() }
        "r" => { KeybdKey::RKey.press() }
        "s" => { KeybdKey::SKey.press() }
        "t" => { KeybdKey::TKey.press() }
        "u" => { KeybdKey::UKey.press() }
        "v" => { KeybdKey::VKey.press() }
        "w" => { KeybdKey::WKey.press() }
        "x" => { KeybdKey::XKey.press() }
        "y" => { KeybdKey::YKey.press() }
        "z" => { KeybdKey::ZKey.press() }
        "numpad0" => { KeybdKey::Numpad0Key.press() }
        "numpad1" => { KeybdKey::Numpad1Key.press() }
        "numpad2" => { KeybdKey::Numpad2Key.press() }
        "numpad3" => { KeybdKey::Numpad3Key.press() }
        "numpad4" => { KeybdKey::Numpad4Key.press() }
        "numpad5" => { KeybdKey::Numpad5Key.press() }
        "numpad6" => { KeybdKey::Numpad6Key.press() }
        "numpad7" => { KeybdKey::Numpad7Key.press() }
        "numpad8" => { KeybdKey::Numpad8Key.press() }
        "numpad9" => { KeybdKey::Numpad9Key.press() }
        "f1" => { KeybdKey::F1Key.press() }
        "f2" => { KeybdKey::F2Key.press() }
        "f3" => { KeybdKey::F3Key.press() }
        "f4" => { KeybdKey::F4Key.press() }
        "f5" => { KeybdKey::F5Key.press() }
        "f6" => { KeybdKey::F6Key.press() }
        "f7" => { KeybdKey::F7Key.press() }
        "f8" => { KeybdKey::F8Key.press() }
        "f9" => { KeybdKey::F9Key.press() }
        "f10" => { KeybdKey::F10Key.press() }
        "f11" => { KeybdKey::F11Key.press() }
        "f12" => { KeybdKey::F12Key.press() }
        "f13" => { KeybdKey::F13Key.press() }
        "f14" => { KeybdKey::F14Key.press() }
        "f15" => { KeybdKey::F15Key.press() }
        "f16" => { KeybdKey::F16Key.press() }
        "f17" => { KeybdKey::F17Key.press() }
        "f18" => { KeybdKey::F18Key.press() }
        "f19" => { KeybdKey::F19Key.press() }
        "f20" => { KeybdKey::F20Key.press() }
        "f21" => { KeybdKey::F21Key.press() }
        "f22" => { KeybdKey::F22Key.press() }
        "f23" => { KeybdKey::F23Key.press() }
        "f24" => { KeybdKey::F24Key.press() }
        "numlock" => { KeybdKey::NumLockKey.press() }
        "scrolllock" => { KeybdKey::ScrollLockKey.press() }
        "capslock" => { KeybdKey::CapsLockKey.press() }
        "lshift" => { KeybdKey::LShiftKey.press() }
        "rshift" => { KeybdKey::RShiftKey.press() }
        "lcontrol" => { KeybdKey::LControlKey.press() }
        "rcontrol" => { KeybdKey::RControlKey.press() }

        _ => println!("something else!"),
    }
}

pub fn release_key(key: String) {
    let key_to_match: String = key.to_lowercase();
    match key_to_match.as_str() {
        "backspace" => { KeybdKey::BackspaceKey.release() }
        "tab" => { KeybdKey::TabKey.release() }
        "enter" => { KeybdKey::EnterKey.release() }
        "escape" => { KeybdKey::EscapeKey.release() }
        "space" => { KeybdKey::SpaceKey.release() }
        "home" => { KeybdKey::HomeKey.release() }
        "left" => { KeybdKey::LeftKey.release() }
        "up" => { KeybdKey::UpKey.release() }
        "right" => { KeybdKey::RightKey.release() }
        "down" => { KeybdKey::DownKey.release() }
        "insert" => { KeybdKey::InsertKey.release() }
        "delete" => { KeybdKey::DeleteKey.release() }
        "numrow0" => { KeybdKey::Numrow0Key.release() }
        "numrow1" => { KeybdKey::Numrow1Key.release() }
        "numrow2" => { KeybdKey::Numrow2Key.release() }
        "numrow3" => { KeybdKey::Numrow3Key.release() }
        "numrow4" => { KeybdKey::Numrow4Key.release() }
        "numrow5" => { KeybdKey::Numrow5Key.release() }
        "numrow6" => { KeybdKey::Numrow6Key.release() }
        "numrow7" => { KeybdKey::Numrow7Key.release() }
        "numrow8" => { KeybdKey::Numrow8Key.release() }
        "numrow9" => { KeybdKey::Numrow9Key.release() }
        "a" => { KeybdKey::AKey.release() }
        "b" => { KeybdKey::BKey.release() }
        "c" => { KeybdKey::CKey.release() }
        "d" => { KeybdKey::DKey.release() }
        "e" => { KeybdKey::EKey.release() }
        "f" => { KeybdKey::FKey.release() }
        "g" => { KeybdKey::GKey.release() }
        "h" => { KeybdKey::HKey.release() }
        "i" => { KeybdKey::IKey.release() }
        "j" => { KeybdKey::JKey.release() }
        "k" => { KeybdKey::KKey.release() }
        "l" => { KeybdKey::LKey.release() }
        "m" => { KeybdKey::MKey.release() }
        "n" => { KeybdKey::NKey.release() }
        "o" => { KeybdKey::OKey.release() }
        "p" => { KeybdKey::PKey.release() }
        "q" => { KeybdKey::QKey.release() }
        "r" => { KeybdKey::RKey.release() }
        "s" => { KeybdKey::SKey.release() }
        "t" => { KeybdKey::TKey.release() }
        "u" => { KeybdKey::UKey.release() }
        "v" => { KeybdKey::VKey.release() }
        "w" => { KeybdKey::WKey.release() }
        "x" => { KeybdKey::XKey.release() }
        "y" => { KeybdKey::YKey.release() }
        "z" => { KeybdKey::ZKey.release() }
        "numpad0" => { KeybdKey::Numpad0Key.release() }
        "numpad1" => { KeybdKey::Numpad1Key.release() }
        "numpad2" => { KeybdKey::Numpad2Key.release() }
        "numpad3" => { KeybdKey::Numpad3Key.release() }
        "numpad4" => { KeybdKey::Numpad4Key.release() }
        "numpad5" => { KeybdKey::Numpad5Key.release() }
        "numpad6" => { KeybdKey::Numpad6Key.release() }
        "numpad7" => { KeybdKey::Numpad7Key.release() }
        "numpad8" => { KeybdKey::Numpad8Key.release() }
        "numpad9" => { KeybdKey::Numpad9Key.release() }
        "f1" => { KeybdKey::F1Key.release() }
        "f2" => { KeybdKey::F2Key.release() }
        "f3" => { KeybdKey::F3Key.release() }
        "f4" => { KeybdKey::F4Key.release() }
        "f5" => { KeybdKey::F5Key.release() }
        "f6" => { KeybdKey::F6Key.release() }
        "f7" => { KeybdKey::F7Key.release() }
        "f8" => { KeybdKey::F8Key.release() }
        "f9" => { KeybdKey::F9Key.release() }
        "f10" => { KeybdKey::F10Key.release() }
        "f11" => { KeybdKey::F11Key.release() }
        "f12" => { KeybdKey::F12Key.release() }
        "f13" => { KeybdKey::F13Key.release() }
        "f14" => { KeybdKey::F14Key.release() }
        "f15" => { KeybdKey::F15Key.release() }
        "f16" => { KeybdKey::F16Key.release() }
        "f17" => { KeybdKey::F17Key.release() }
        "f18" => { KeybdKey::F18Key.release() }
        "f19" => { KeybdKey::F19Key.release() }
        "f20" => { KeybdKey::F20Key.release() }
        "f21" => { KeybdKey::F21Key.release() }
        "f22" => { KeybdKey::F22Key.release() }
        "f23" => { KeybdKey::F23Key.release() }
        "f24" => { KeybdKey::F24Key.release() }
        "numlock" => { KeybdKey::NumLockKey.release() }
        "scrolllock" => { KeybdKey::ScrollLockKey.release() }
        "capslock" => { KeybdKey::CapsLockKey.release() }
        "lshift" => { KeybdKey::LShiftKey.release() }
        "rshift" => { KeybdKey::RShiftKey.release() }
        "lcontrol" => { KeybdKey::LControlKey.release() }
        "rcontrol" => { KeybdKey::RControlKey.release() }
        _ => println!("something else!"),
    }
}