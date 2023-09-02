extends Node2D

onready var textbox = $RichTextLabel/BLabel
var speed = 0.0

var stop = false
var writing = false

var signalQueue := [] #signals in spirit, but not gdscript signals

# Add a signal to the queue
func enqueueSignal(signal_data):
	signalQueue.append(signal_data)
		
# Check if the queue is being processed
func is_processing_queue():
	var size = signalQueue.size()
	return size > 0
	
# Process the next signal in the queue
func processNextSignal():
	if signalQueue.size() > 0:
		var signal_data = signalQueue[0]  # Peek at the front of the queue
		textbox.set_text("")
		writing = true
		for c in signal_data:
			if stop:
				stop = false
				break
			textbox.text += c
			yield(get_tree().create_timer(speed), "timeout")
		writing = false
		print("Processing signal:", signal_data)	
		signalQueue.remove(0)  # Remove the processed signal
		# Continue to the next signal
		if signalQueue.size() > 0:
			processNextSignal()  # Process next signal in the queue

func set_text(text):
	enqueueSignal(text)
	if signalQueue.size() == 1:  # Start processing if queue was empty
		processNextSignal()

	
func set_text_now(text):
	stop = true
	textbox.set_text(text)
