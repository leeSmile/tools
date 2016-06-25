

/**
 *     便捷定义@property属性
 */




/** copy */

//NSString
#define String_(name) \
    zzn_copy_property(NSString*,name)
//NSArray
#define Array_(name) \
    zzn_copy_property(NSArray*,name)
//NSDictionary
#define Dictionary_(name) \
    zzn_copy_property(NSDictionary*,name)
//NSNumber,它没用对应的不可变类，其实用copy或strong没有区别
#define Number_(name) \
    zzn_copy_property(NSNumber*,name)
//NSData
#define Data_(name) \
    zzn_copy_property(NSData*,name)
//NSSet
#define Set_(name) \
    zzn_copy_property(NSSet*,name)
//NSIndexSet
#define IndexSet_(name) \
    zzn_copy_property(NSIndexSet*,name)

//代码块，名称和传参，没有传参就不填
#define Block_(name,...) \
    zzn_set_block(void,name,__VA_ARGS__)
//有返回值的代码块
#define BlockReturn_(name,returnClass,...) \
    zzn_set_block(returnClass,name,__VA_ARGS__)






/** strong */

//NSMutableString
#define mString_(name,...) \
    zzn_strong_property(NSMutableString*,name,__VA_ARGS__)
//NSMutableArray
#define mArray_(name,...) \
    zzn_strong_property(NSMutableArray*,name,__VA_ARGS__)
//NSMutableDictionary
#define mDictionary_(name,...) \
    zzn_strong_property(NSMutableDictionary*,name,__VA_ARGS__)
//NSMutableData
#define mData_(name,...) \
    zzn_strong_property(NSMutableData*,name,__VA_ARGS__)
//NSMutableSet
#define mSet_(name,...) \
    zzn_strong_property(NSMutableSet*,name,__VA_ARGS__)
//NSMutableIndexSet
#define mIndexSet_(name,...) \
    zzn_strong_property(NSMutableIndexSet*,name,__VA_ARGS__)

//UIImage
#define Image_(name) \
    zzn_strong_property(UIImage*,name)
//UIColor
#define Color_(name) \
    zzn_strong_property(UIColor*,name)
//id
#define id_(name,...) \
    zzn_strong_property(id,name,__VA_ARGS__)

//UIView
#define View_(name,...) \
    zzn_strong_property(UIView*,name,__VA_ARGS__)
//UIImageView
#define ImageView_(name,...) \
    zzn_strong_property(UIImageView*,name,__VA_ARGS__)
//UILabel
#define Label_(name,...) \
    zzn_strong_property(UILabel*,name,__VA_ARGS__)
//UIButton
#define Button_(name,...) \
    zzn_strong_property(UIButton*,name,__VA_ARGS__)
//UITableView
#define TableView_(name,...) \
    zzn_strong_property(UITableView*,name,__VA_ARGS__)
//UICollectionView
#define CollectionView_(name,...) \
    zzn_strong_property(UICollectionView*,name,__VA_ARGS__)
//UISegmentedControl
#define SegmentedControl_(name,...) \
    zzn_strong_property(UISegmentedControl*,name,__VA_ARGS__)
//UITextField
#define TextField_(name,...) \
    zzn_strong_property(UITextField*,name,__VA_ARGS__)
//UISlider
#define Slider_(name,...) \
    zzn_strong_property(UISlider*,name,__VA_ARGS__)
//UISwitch
#define Switch_(name,...) \
    zzn_strong_property(UISwitch*,name,__VA_ARGS__)
//UIActivityIndicatorView
#define ActivityIndicatorView_(name,...) \
    zzn_strong_property(UIActivityIndicatorView*,name,__VA_ARGS__)
//UIProgressView
#define ProgressView_(name,...) \
    zzn_strong_property(UIProgressView*,name,__VA_ARGS__)
//UIPageControl
#define PageControl_(name,...) \
    zzn_strong_property(UIPageControl*,name,__VA_ARGS__)
//UIStepper
#define Stepper_(name,...) \
    zzn_strong_property(UIStepper*,name,__VA_ARGS__)
//UITextView
#define TextView_(name,...) \
    zzn_strong_property(UITextView*,name,__VA_ARGS__)
//UIScrollView
#define ScrollView_(name,...) \
    zzn_strong_property(UIScrollView*,name,__VA_ARGS__)
//UIDatePicker
#define DatePicker_(name,...) \
    zzn_strong_property(UIDatePicker*,name,__VA_ARGS__)
//UIPickerView
#define PickerView_(name,...) \
    zzn_strong_property(UIPickerView*,name,__VA_ARGS__)
//UIWebView
#define WebView_(name,...) \
    zzn_strong_property(UIWebView*,name,__VA_ARGS__)
//自定义类
#define DIYObj_(class,name,...) \
    zzn_strong_property(class*,name,__VA_ARGS__)





/** assign */

//int
#define int_(name,...) \
    zzn_assign_property(int,name,__VA_ARGS__)
//float
#define float_(name,...) \
    zzn_assign_property(float,name,__VA_ARGS__)
//double
#define double_(name,...) \
    zzn_assign_property(double,name,__VA_ARGS__)
//CGFloat
#define CGFloat_(name,...) \
    zzn_assign_property(CGFloat,name,__VA_ARGS__)
//NSInteger
#define NSInteger_(name,...) \
    zzn_assign_property(NSInteger,name,__VA_ARGS__)
//NSUInteger
#define NSUInteger_(name,...) \
    zzn_assign_property(NSUInteger,name,__VA_ARGS__)
//BOOL
#define BOOL_(name,...) \
    zzn_assign_property(BOOL,name,__VA_ARGS__)
//CGRect
#define CGRect_(name,...) \
    zzn_assign_property(CGRect,name,__VA_ARGS__)
//CGSize
#define CGSize_(name,...) \
    zzn_assign_property(CGSize,name,__VA_ARGS__)
//CGPoint
#define CGPoint_(name,...) \
    zzn_assign_property(CGPoint,name,__VA_ARGS__)
//CGAffineTransform
#define CGAffineTransform_(name,...) \
    zzn_assign_property(CGAffineTransform,name,__VA_ARGS__)
//NSTimeInterval
#define NSTimeInterval_(name,...) \
    zzn_assign_property(NSTimeInterval,name,__VA_ARGS__)
//Class
#define Class_(name) \
    zzn_assign_property(Class,name)




/** weak */

//UIImageView
#define weakImageView_(name,...) \
    zzn_weak_property(UIImageView*,name,__VA_ARGS__)
//UIView
#define weakView_(name,...) \
    zzn_weak_property(UIView*,name,__VA_ARGS__)
//UILabel
#define weakLabel_(name,...) \
    zzn_weak_property(UILabel*,name,__VA_ARGS__)
//UIButton
#define weakButton_(name,...) \
    zzn_weak_property(UIButton*,name,__VA_ARGS__)
//UITableView
#define weakTableView_(name,...) \
    zzn_weak_property(UITableView*,name,__VA_ARGS__)
//UICollectionView
#define weakCollectionView_(name,...) \
    zzn_weak_property(UICollectionView*,name,__VA_ARGS__)
//UISegmentedControl
#define weakSegmentedControl_(name,...) \
    zzn_weak_property(UISegmentedControl*,name,__VA_ARGS__)
//UITextField
#define weakTextField_(name,...) \
    zzn_weak_property(UITextField*,name,__VA_ARGS__)
//UISlider
#define weakSlider_(name,...) \
    zzn_weak_property(UISlider*,name,__VA_ARGS__)
//UISwitch
#define weakSwitch_(name,...) \
    zzn_weak_property(UISwitch*,name,__VA_ARGS__)
//UIActivityIndicatorView
#define weakActivityIndicatorView_(name,...) \
    zzn_weak_property(UIActivityIndicatorView*,name,__VA_ARGS__)
//UIProgressView
#define weakProgressView_(name,...) \
    zzn_weak_property(UIProgressView*,name,__VA_ARGS__)
//UIPageControl
#define weakPageControl_(name,...) \
    zzn_weak_property(UIPageControl*,name,__VA_ARGS__)
//UIStepper
#define weakStepper_(name,...) \
    zzn_weak_property(UIStepper*,name,__VA_ARGS__)
//UITextView
#define weakTextView_(name,...) \
    zzn_weak_property(UITextView*,name,__VA_ARGS__)
//UIScrollView
#define weakScrollView_(name,...) \
    zzn_weak_property(UIScrollView*,name,__VA_ARGS__)
//UIDatePicker
#define weakDatePicker_(name,...) \
    zzn_weak_property(UIDatePicker*,name,__VA_ARGS__)
//UIPickerView
#define weakPickerView_(name,...) \
    zzn_weak_property(UIPickerView*,name,__VA_ARGS__)
//UIWebView
#define weakWebView_(name,...) \
    zzn_weak_property(UIWebView*,name,__VA_ARGS__)
//自定义类
#define weakDIYObj_(class,name,...) \
    zzn_weak_property(class*,name,__VA_ARGS__)

//delegate
#define Delegate_(class,name) \
    zzn_weak_property(id<class>,name)


/** base */

//copy && DIY
#define zzn_copy_property(class,var,...) \
    zzn_set_property(class,var,copy,__VA_ARGS__)
//strong && DIY
#define zzn_strong_property(class,var,...) \
    zzn_set_property(class,var,strong,__VA_ARGS__)
//weak && DIY
#define zzn_weak_property(class,var,...) \
    zzn_set_property(class,var,weak,__VA_ARGS__)
//assign && DIY
#define zzn_assign_property(class,var,...) \
    zzn_set_property(class,var,assign,__VA_ARGS__)
//DIY
#define zzn_diy_property(class,var,...) \
    zzn_set_property(class,var,__VA_ARGS__)
//block
#define zzn_set_block(class,name,...) \
    zzn_set_property(class,(^name)(__VA_ARGS__),copy)

//baseMacro
#define zzn_set_property(class,var,...) \
    @property (nonatomic, __VA_ARGS__) class var;




















/**
 *     其他宏
 */

//block的调用
#define Call(block,...) \
    !block?:block(__VA_ARGS__);
//block的调用，并带有返回值
#define CallRerurn(block,failReturnValue,...) \
    block?(block(__VA_ARGS__)):(failReturnValue)

//防止block的强硬用循环相关
#define Weak(arg) \
    __weak typeof(arg) wArg = arg;
#define Strong(arg) \
    __strong typeof(wArg) arg = wArg;

#define WeakSelf \
    Weak(self)
#define StrongSelf \
    Strong(self)

