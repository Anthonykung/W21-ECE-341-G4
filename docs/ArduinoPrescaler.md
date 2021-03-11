# Arduino ADC Prescaler

Arduino ADC default at 128 Prescaler

Arduino Clock Frequency is 16 MHz

A prescaler of 128 will give the ADC frequency of 16 MHz / 128 = 125 000 Hz

Arduino ADC uses 13 clock cycles to complete

An ADC frequency of 125 kHz will give the sampling rate of 125 kHz / 13 = ~9615 Hz

The 16 prescaler is the lowest we can get without damaging the resolutions

## Prescaler Table

| Prescale | ADPS2 | ADPS1 | ADPS0 | Clock freq (MHz) | Sampling rate (KHz) |
| -------- | ----- | ----- | ----- | ---------------- | ------------------- |
| 2        | 0     | 0     | 1     | 8                | 615                 |
| 4        | 0     | 1     | 0     | 4                | 307                 |
| 8        | 0     | 1     | 1     | 2                | 153                 |
| 16       | 1     | 0     | 0     | 1                | 76.8                |
| 32       | 1     | 0     | 1     | 0.5              | 38.4                |
| 64       | 1     | 1     | 0     | 0.25             | 19.2                |
| 128      | 1     | 1     | 1     | 0.125            | 9.6                 |
