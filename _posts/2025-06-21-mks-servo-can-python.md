---
layout: post
title: Finally! A proper Python library for MKS servo controllers with CAN
category: Hardware
draft: false
published: true
comments: true
---

If you've ever tried to control MKS SERVO42D or SERVO57D stepper motor controllers from Python, you know the pain. These controllers transform regular stepper motors into servo-like systems with closed-loop feedback, position control, and CAN communication. They're affordable and capable, but the lack of a proper Python library meant you were stuck writing raw CAN commands or wrestling with incomplete code snippets scattered across forums.

**Not anymore.**

I just released [mks-servo-can](https://github.com/ricardodeazambuja/mks_servo_can) — a complete Python library that finally gives these motor controllers the control interface they deserve.

<!--more-->

## 🎯 **The Problem That Needed Solving**

MKS servo controllers communicate over CAN bus, turning regular stepper motors into closed-loop servo systems. It sounds straightforward until you realize:

- The documentation is... let's call it "minimalist"
- No official Python support (just some basic examples)
- Raw CAN commands are a nightmare to debug
- Building multi-axis systems means reinventing the wheel every time
- Testing without physical hardware? Good luck with that.

I needed this for my own robotics projects, and frankly, I was tired of the same frustrating experience every time I wanted to prototype something with these servo controllers.

## 🛠️ **What I Built (With AI Assistance)**

This wasn't a "code it in a weekend" project. I spent weeks iterating with multiple AI models — Claude Code for the heavy lifting, Gemini for brainstorming, and Jules for the tricky bits. 

**The secret sauce? I designed the development process around comprehensive testing and simulation from day one.** This meant the AI agents could write, test, and iterate on code without any physical hardware. They could validate motor control algorithms, test edge cases, and debug communication protocols entirely in the simulator.

The result is a comprehensive library that includes:

**✅ Async-first design** — Because blocking I/O is so 2010  
**✅ High-level motor control** — Move in real units (mm, degrees) instead of encoder pulses  
**✅ Multi-axis coordination** — Synchronize multiple motor controllers effortlessly  
**✅ Robot kinematics** — Built-in support for common robot configurations  
**✅ Motor digitizer system** — Record manual movements and play them back with precision testing  
**✅ Hardware simulator** — Develop and test without physical motor controllers  
**✅ Rich debugging tools** — Interactive dashboard, HTTP API, and comprehensive logging

## 🚀 **Show Me The Code**

Here's how simple it is to get started ([example based on the repo's conceptual snippet](https://github.com/ricardodeazambuja/mks_servo_can#conceptual-snippet-connecting-to-the-simulator)):

```python
import asyncio
from mks_servo_can import (
    CANInterface, Axis, RotaryKinematics, const, exceptions
)

async def simple_control():
    # Connect to real hardware or simulator
    can_if = CANInterface(use_simulator=True, simulator_host='localhost', simulator_port=6789)
    await can_if.connect()
    
    # Create a motor axis with real-world units
    # Using default encoder pulses for MKS servos (16384 pulses/rev)
    kin = RotaryKinematics(steps_per_revolution=const.ENCODER_PULSES_PER_REVOLUTION)
    motor = Axis(can_if, motor_can_id=1, name="SimMotor1", kinematics=kin)
    
    try:
        await motor.initialize()  # Basic communication check
        await motor.enable_motor()
        
        initial_pos_deg = await motor.get_current_position_user()
        print(f"Motor '{motor.name}' initial position: {initial_pos_deg:.2f} degrees")
        
        # Move 90 degrees at 180 deg/s speed
        await motor.move_to_position_abs_user(initial_pos_deg + 90.0, speed_user=180.0, wait=True)
        
        final_pos_deg = await motor.get_current_position_user()
        print(f"Motor '{motor.name}' final position: {final_pos_deg:.2f} degrees")
        
        await motor.disable_motor()
    except exceptions.MKSServoError as e:
        print(f"Error: {e}")
    finally:
        await can_if.disconnect()

asyncio.run(simple_control())
```

But it gets much more interesting when you need multi-axis control ([see multi_axis_simulator.py example](https://github.com/ricardodeazambuja/mks_servo_can/blob/main/examples/multi_axis_simulator.py)):

```python
from mks_servo_can import MultiAxisController, create_linear_axis

async def multi_axis_demo():
    can_if = CANInterface(use_simulator=True, simulator_host='localhost', simulator_port=6789)
    await can_if.connect()
    
    controller = MultiAxisController(can_if)
    
    # Add axes with different kinematics
    x_axis = create_linear_axis(can_if, 1, "X", lead_screw_pitch=40.0)  # 40mm/rev
    y_axis = create_linear_axis(can_if, 2, "Y", lead_screw_pitch=40.0)
    
    await controller.add_axis(x_axis)
    await controller.add_axis(y_axis)
    await controller.initialize_axes()
    
    # Coordinated movement - both axes move simultaneously
    await controller.move_axes_to_positions_abs_user(
        {"X": 100.0, "Y": 50.0},  # Move to X=100mm, Y=50mm
        speeds_user={"X": 200.0, "Y": 200.0},  # 200mm/s each
        wait=True
    )
    
    positions = await controller.get_all_positions_user()
    print(f"Final positions: {positions}")
    
    await controller.cleanup()
    await can_if.disconnect()
```

## 🎮 **Simulation-First Development: The Real Game Changer**

One of my favorite features is the hardware simulator — and it's not just a nice-to-have feature, it was **central to the entire development strategy**.

The simulator isn't just about convenience; it enabled a completely new development workflow. You can develop entire multi-axis control systems, validate robot kinematics, and test complex motion sequences without connecting a single servo controller.

**Start the simulator** ([full options in the documentation](https://github.com/ricardodeazambuja/mks_servo_can#basic-simulator-usage)):

```bash
# Start interactive simulator with dashboard
mks-servo-simulator --dashboard --num-motors 3 --refresh-rate 200
```

The simulator includes:
- **Real-time dashboard** with motor status, position tracking, and performance metrics
- **Interactive controls** for live parameter adjustment
- **HTTP REST API** for programmatic access (perfect for automated testing)
- **Configuration profiles** to save/load different setups
- **Command injection tools** for debugging tricky CAN communication issues

**But here's the bigger picture:** This simulation-first approach allowed the AI agents to develop and test the entire codebase without hardware dependencies. They could validate control algorithms, test error handling, and debug communication protocols in a deterministic environment.

**What's next for simulation?** The plan is to evolve beyond the current TCP-based simulator and integrate with proper physics engines like **Gazebo**, **NVIDIA Isaac**, and **MuJoCo**. Imagine developing your robot control code with full physics simulation, then deploying the exact same code to real hardware. That's the vision.

## 🎯 **Real Robot Integration**

The library includes kinematic models for common robot configurations ([see robot_kinematics.py](https://github.com/ricardodeazambuja/mks_servo_can/blob/main/mks_servo_can_library/mks_servo_can/robot_kinematics.py)). Want to control a 2-DOF planar arm? Here's all you need ([based on two_link_planar_arm.py example](https://github.com/ricardodeazambuja/mks_servo_can/blob/main/examples/two_link_planar_arm.py)):

```python
from mks_servo_can import TwoLinkArmPlanar

# Define your arm geometry
robot = TwoLinkArmPlanar(
    can_interface=can_if,
    motor_can_ids=[1, 2],
    link_lengths=[200.0, 150.0],  # mm
    axis_names=["Shoulder", "Elbow"]
)

await robot.initialize()

# Move end-effector to Cartesian coordinates
await robot.move_to_cartesian_position(x=250.0, y=100.0, wait=True)
```

The library handles all the inverse kinematics, joint coordination, and error checking automatically.

## 🔬 **Motor Digitizer: Manual Teaching Made Easy**

Need to teach a robot a complex path manually? The motor digitizer system ([see digitizer documentation](https://github.com/ricardodeazambuja/mks_servo_can/tree/main/mks_servo_can_library/mks_servo_can/digitizer)) lets you record manual movements and play them back with precision analysis ([example: motor_digitizer.py](https://github.com/ricardodeazambuja/mks_servo_can/blob/main/examples/motor_digitizer.py)):

```python
from mks_servo_can import MotorDigitizer, PrecisionAnalyzer

digitizer = MotorDigitizer(can_if)
await digitizer.add_axis(x_axis)
await digitizer.add_axis(y_axis)
await digitizer.initialize_axes()

# Record manual movement (motors disabled for hand-guiding)
await digitizer.start_recording(sample_rate=10.0)
# ... manually move the robot ...
await digitizer.stop_recording()

# Play back with precision testing
stats = await digitizer.playback_sequence(
    digitizer.current_sequence, 
    precision_test=True
)

# Get precision assessment: EXCELLENT/GOOD/FAIR/POOR
assessment = PrecisionAnalyzer.assess_precision(stats)
print(f"System precision: {assessment}")

await digitizer.cleanup()
```

## 🚀 **Ready to Try It?**

The library is **MIT licensed** and ready for your projects. Here's how to get started ([installation guide](https://github.com/ricardodeazambuja/mks_servo_can#installation)):

```bash
# Install the library
cd mks_servo_can_library
pip install -e .

# Install the simulator
cd ../mks_servo_simulator  
pip install -e .

# Try the examples
python examples/multi_axis_simulator.py
```

**Want to try specific features?** Check out the [comprehensive examples directory](https://github.com/ricardodeazambuja/mks_servo_can/tree/main/examples):
- [Single axis control](https://github.com/ricardodeazambuja/mks_servo_can/blob/main/examples/single_axis_real_hw.py) with real hardware
- [Multi-axis coordination](https://github.com/ricardodeazambuja/mks_servo_can/blob/main/examples/multi_axis_simulator.py) with the simulator  
- [Robot kinematics examples](https://github.com/ricardodeazambuja/mks_servo_can/blob/main/examples/two_link_planar_arm.py) for different robot types
- [Motor digitizer demos](https://github.com/ricardodeazambuja/mks_servo_can/blob/main/examples/basic_digitizer_demo.py) for manual teaching
- [Performance benchmarking](https://github.com/ricardodeazambuja/mks_servo_can/blob/main/examples/benchmark_command_latency.py) and timing analysis

## 🤝 **Help Make It Better**

This is where I need **your help**. The library works great for my use cases, but robotics is diverse and I'm sure there are edge cases I haven't hit yet.

**I'm looking for:**
- **Beta testers** with real MKS servo controllers to stress-test the hardware interface
- **Contributors** who want to add support for other servo controller models or features  
- **Feedback** on the API design — is it intuitive? What's missing?
- **Bug reports** when (not if) you find issues

The codebase is well-documented, thoroughly tested, and designed to be hackable. Whether you want to add new kinematics models, improve the simulator, or optimize performance, there's plenty of room for contribution.

## 💭 **The AI Development Experience: Testing Without Hardware**

Working with multiple AI models on this project was enlightening, but the real breakthrough was the **simulation-first development approach**.

By building comprehensive tests and a realistic simulator upfront, I created an environment where Claude Code, Gemini, and Jules could write, test, and validate code without ever touching real hardware. They could:

- **Write motor control algorithms** and immediately test them in simulation
- **Debug CAN communication** using the virtual bus
- **Validate multi-axis coordination** with complex motion sequences  
- **Test error handling** by simulating hardware failures
- **Benchmark performance** with realistic timing constraints

The key was treating them like a team of junior developers with access to a **perfect test lab**. No waiting for hardware, no risk of damaging expensive equipment, no need to constantly plug/unplug cables to test different scenarios.

This approach doesn't just benefit AI development — **it transforms how humans develop robotics code too.** You can prototype entire systems, validate your algorithms, and iron out bugs long before your hardware arrives. The same tests that guided the AI agents will catch your bugs too.

## 🎉 **What's Next?**

I'm planning to add support for more MKS servo controller models, implement trajectory optimization algorithms, and expand the robot kinematics library. But honestly, the roadmap depends on what the community needs.

**So... what would you build with proper MKS servo controller support?**

Check out the [GitHub repository](https://github.com/ricardodeazambuja/mks_servo_can), kick the tires, and let me know what breaks. The robot revolution starts with better tools, and I think this library is a solid step forward.

Happy building! 🤖