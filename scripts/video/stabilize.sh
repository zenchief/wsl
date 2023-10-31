#!/bin/bash

if [ $# -ne 1 ]; then
	    echo "Usage: $0 <input_video>"
	        exit 1
fi

input_video="$1"
output_video="stab_${input_video}"

# Step 1: Analyze the video to detect motion and create a metadata file
ffmpeg -i "$input_video" -vf vidstabdetect=stepsize=6:shakiness=5:accuracy=15:result=transform.trf -f null -

# Step 2: Apply stabilization using the generated metadata
ffmpeg -i "$input_video" -vf vidstabtransform=input=transform.trf:zoom=1:smoothing=10,unsharp=5:5:0.8:3:3:0.4 "$output_video"

echo "Stabilized video saved as $output_video"

