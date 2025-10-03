{
    "ignition": { "version": "3.0.0" },
    "systemd": {
        "units": [{
            "name": "danger_wiper.service",
            "enabled": true,
            "contents": "[Service]\nType=oneshot\nExecStart=/usr/local/bin/danger_wiper.sh\n\n[Install]\nWantedBy=multi-user.target"
        }]
    },
    "storage": {
        "files": [{
            "path": "/usr/local/bin/danger_wiper.sh",
            "mode": 493,
            "contents": {
                "source": "data:text/plain;charset=utf-8;base64,${BASE64_ENC_SCRIPT}"
            }
        }]
    }
}