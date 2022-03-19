use std::iter::Map;
use config::{Config, ConfigError, File};
use serde_derive::Deserialize;

#[derive(Debug, Deserialize)]
pub struct CommandConfig {
    pub trigger: String,
    pub command: Option<String>,
    pub args: Option<Vec<String>>,
}


#[derive(Debug, Deserialize)]
pub struct MappingConfig {
    pub trigger: String,
    pub mapping: Option<Vec<String>>,
}

#[derive(Debug, Deserialize)]
pub struct Settings {
    pub server: String,
    pub phrase: Option<String>,
    pub mappings: Option<MappingConfig>,
    pub commands: Option<Vec<CommandConfig>>,
}

impl Settings {
    pub fn new() -> Result<Self, ConfigError> {
        let s = Config::builder()
            // Start off by merging in the "default" configuration file
            .add_source(File::with_name("config.yml"))
            // Add in the current environment file
            // Default to 'development' env
            // Note that this file is _optional_
            // .add_source(
            //     File::with_name(&format!("examples/hierarchical-env/config/{}", run_mode))
            //         .required(false),
            // )
            // Add in a local configuration file
            // This file shouldn't be checked in to git
            // .add_source(File::with_name("examples/hierarchical-env/config/local").required(false))
            // Add in settings from the environment (with a prefix of APP)
            // Eg.. `APP_DEBUG=1 ./target/app` would set the `debug` key
            // .add_source(Environment::with_prefix("app"))
            // You may also programmatically change settings
            // .set_override("database.url", "postgres://")?
            .build()?;

        // Now that we're done, let's access our configuration

        // You can deserialize (and thus freeze) the entire configuration as
        s.try_deserialize()
    }
}
