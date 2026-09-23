use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct AnalyticsConfig {
    pub api_key: String,
    pub host: Option<String>,
    pub enabled: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UserSession {
    pub session_id: String,
    pub user_id: String,
    pub is_active: bool,
}

pub struct AnalyticsClient {
    #[allow(dead_code)]
    config: AnalyticsConfig,
}

impl AnalyticsClient {
    pub async fn new(config: AnalyticsConfig) -> Self {
        Self { config }
    }

    pub fn is_enabled(&self) -> bool {
        false
    }
}
