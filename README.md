# sling
This is a signals and slots library for nim.

### Performance
**sling** is around 10x slower than traditional callbacks, which is the same speed as Qt's signal and slots library.
A signal callback takes around 2ns, which a C callback version will take around 0.2ns overall, not much to worry about.

### Usage
```nim
import sling

# The 'slot' keyword is just a typedef of 'void'.
# A slot needs to have a 'void' return value, so
# just use the 'slot' keyword for simplicity and style.

# Currently only 1 parameter value is supported in a slot, I will look more into this.

proc callback( i: int ): slot =
  echo( "callback received: ", i )

var sig = signal[int]()

sig.connect( callback )
sig.connect( proc( i: int ): slot =
               echo( "lambda recieved: ", i ) )
               
sig.emit( 200 ) # will print 'callback recieved 200' and 'lambda recieved 200'

# disconnect all callbacks
sig.clear()


```
