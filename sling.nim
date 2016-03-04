import sequtils

type

  slot* = void
  callback[T] = proc( t: T ): slot
  Signal*[T] = object
    connectionsList: seq[ callback[T] ]

proc signal*[T](): Signal[T] =
  result.connectionsList = newSeq[ callback[T] ](0)

proc connect*[T, R]( self: var Signal[T], r: R ): void =
  self.connectionsList.add( r )

proc disconnect*[T, S]( self: var Signal[T], cb: S ): void =
  for i in 0..len(self.connectionsList) - 1:
    var c = self.connectionsList[ i ]
    if c == cb:
      self.connectionsList.delete( i, i )
      break;

proc clear*[T]( self: var Signal[T] ): void =
  self.connectionsList = newSeq[ callback[T] ](0)

proc emit*[T, R]( self: Signal[T], r: R ): void =
  for c in self.connectionsList:
    c( r )

proc emit*[T]( self: Signal[T] ): void =
  for c in self.connectionsList:
    c()

iterator connections*[T]( self: Signal[T] ): (callback[T]) =
  for c in self.connectionsList:
    yield c

when isMainModule:
  var sig = signal[void]()

  sig.connect( proc(): slot =
                 echo("in proc") )

  sig.emit()
