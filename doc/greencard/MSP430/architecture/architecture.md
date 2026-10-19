# ARCHITECTURE

| **Key**     | **Bit Accessibility**                                                                              |
|:------------|:---------------------------------------------------------------------------------------------------|
| `rw`        | Read/Write                                                                                         |
| `r`         | Read only                                                                                          |
| `r0`        | Read as 0                                                                                          |
| `r1`        | Read as 1                                                                                          |
| `w`         | Write only                                                                                         |
| `w0`        | Write as 0                                                                                         |
| `w1`        | Write as 1                                                                                         |
| `(w)`       | No register bit implemented; writing a 1 results in a pulse. The register bit is always read as 0. |
| `h0`        | Cleared by hardware                                                                                |
| `h1`        | Set by hardware                                                                                    |
| `−0,−1`     | Condition after PUC                                                                                |
| `−(0),−(1)` | Condition after POR                                                                                |
