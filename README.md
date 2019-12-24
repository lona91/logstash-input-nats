# Logstash NATS Input plugin
## Installation
```bash
    git clone https://github.com/lona91/logstash-input-nats.git
    cd logstash-input-nats
    jruby -S gem build logstash-input-nats.gemspec
    $LOGSTASH_PATH/bin/logstash-plugin install logstash-input-nats-1.0.0.gem
```
## Usage
   ```
    input {
        nats {
            host => "nats://localhost:4222"
            channel => "log"
        }
    }
    
    filter {}
    
    output {}
   ```
    
## Options

 Option                 | Type          | Default                   | Description
|--------                |---------     |---------                  |------------
| `host`                 | `string`     | `"nats://localhost:4222"` | Default NATS host
| `channel`              | `string`     |  `"log"`                  | Channel to subscribe to